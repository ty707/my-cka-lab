#!/bin/bash
# 等待 K8s 完全启动
while [ ! -f /etc/kubernetes/admin.conf ]; do sleep 1; done
export KUBECONFIG=/etc/kubernetes/admin.conf

# 创建命名空间
kubectl create ns autoscale

# 创建 deployment (题目暗示已有)
kubectl create deployment apache-server -n autoscale --image=nginx:alpine

# 暴露 metrics-server (HPA 需要)
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl patch deployment metrics-server -n kube-system --type='json' -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls"}]'
