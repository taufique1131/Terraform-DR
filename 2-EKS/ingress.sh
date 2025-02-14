#!/bin/bash

cluster_name=eks-cluster-dr-hyd-cluster
region=ap-south-2
oidc_id=$(aws eks describe-cluster --region $region --name $cluster_name --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)

echo $oidc_id

eksctl utils associate-iam-oidc-provider \
    --cluster $cluster_name \
    --region $region \
    --approve

eksctl create iamserviceaccount \
    --region=$region \
    --cluster=$cluster_name \
    --namespace=kube-system \
    --name=aws-load-balancer-controller \
    --attach-policy-arn=arn:aws:iam::609459977430:policy/AWSLoadBalancerControllerIAMPolicy \
    --approve

helm repo add eks https://aws.github.io/eks-charts && helm repo update eks

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=$cluster_name \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set vpcId=vpc-070e1fab88acfa846 