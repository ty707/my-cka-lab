#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf

# 检查 Ingress 是否存在
if ! kubectl get ingress my-ingress &> /dev/null; then
  echo "Error: Ingress 'my-ingress' not found."
  exit 1
fi

# 检查 Host 规则
HOSTS=$(kubectl get ingress my-ingress -o jsonpath='{.spec.rules[*].host}')
if [[ "$HOSTS" != *"app.example.com"* ]] || [[ "$HOSTS" != *"api.example.com"* ]]; then
  echo "Error: Ingress host rules are incorrect. Expected: app.example.com and api.example.com."
  exit 1
fi

echo "Success: Ingress routing rules are configured correctly!"
exit 0
