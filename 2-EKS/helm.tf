resource "helm_release" "systemx-release" {
    chart = "${path.module}/helm-chart"
    name = "systemx-dr"
    create_namespace = true
    namespace = "systemx"
    cleanup_on_fail = true
    recreate_pods = true
    force_update = true
    replace = true
    values = [ "${file("${path.module}/helm-chart/values.yaml")}"]
    provisioner "local-exec" {
      command = "sleep 20"
    }
    wait = false
}

data "kubernetes_ingress_v1" "systemx-ingress-api-alb" {
  metadata {
    name = "systemx-prod-hyd-dr-ingress" 
    namespace =  helm_release.systemx-release.namespace
  }
}

data "aws_lb" "systemx-ingress-api-alb" {
  name = "systemx-prod-api-hyd-dr-ingress"
}

data "aws_lb" "Main-NLB" {
  name = "Main-NLB-Hyd"
}

resource "aws_lb_target_group" "ingress-api-alb-TG" {
  name = "Sysx-Hyd-internal-ingress-TG"
  port = 80
  protocol = "TCP"
  target_type = "alb"
  vpc_id = data.aws_subnet.PVT-APP-2a.vpc_id
  health_check {
    enabled = true
    port = "traffic-port"
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "ingress-api-alb-TG-attachment" {
  target_group_arn = aws_lb_target_group.ingress-api-alb-TG.arn
  target_id        = data.aws_lb.systemx-ingress-api-alb.arn
  port             = 80
}

resource "aws_lb_listener" "systemx-ingress-api" {
  load_balancer_arn = data.aws_lb.Main-NLB.arn
  port = "8080"
  protocol = "TCP"
  default_action {
    target_group_arn = aws_lb_target_group.ingress-api-alb-TG.arn
    type = "forward"
  }
}


output "alb-url" {
precondition {
  condition = length(data.kubernetes_ingress_v1.systemx-ingress-api-alb.status) != 0  && helm_release.systemx-release.status == "deployed"
  error_message = "ALB is not up yet"
}
value = data.kubernetes_ingress_v1.systemx-ingress-api-alb.status.0.load_balancer.0.ingress.0.hostname
}


