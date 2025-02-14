# resource "helm_release" "systemx-release" {
#     chart = "${path.module}/helm-chart"
#     name = "systemx-dr"
#     create_namespace = true
#     namespace = "systemx"
#     cleanup_on_fail = true
#     recreate_pods = true
#     force_update = true
#     replace = true
#     values = [ "${file("${path.module}/helm-chart/values.yaml")}"]
# }