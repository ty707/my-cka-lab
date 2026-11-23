#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf
while [ ! -f /etc/kubernetes/admin.conf ]; do sleep 1; done
sleep 10

# 创建测试用的后端服务
kubectl create deploy web-app --image=nginx:alpine
kubectl expose deploy web-app --name=web-svc --port=80
kubectl create deploy api-app --image=nginx:alpine
kubectl expose deploy api-app --name=api-svc --port=80

# 部署 Nginx Ingress Controller (仅用于验证，实际可用轻量级)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/baremetal/deploy.yaml
