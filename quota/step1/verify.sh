#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf

# 检查 Namespace 是否创建
if ! kubectl get ns dev-namespace &> /dev/null; then
  echo "Error: Namespace 'dev-namespace' not found."
  exit 1
fi

# 检查 ResourceQuota 的硬限制数值
CPU_LIMIT=$(kubectl get resourcequota compute-quota -n dev-namespace -o jsonpath='{.spec.hard.requests\.cpu}')
MEM_LIMIT=$(kubectl get resourcequota compute-quota -n dev-namespace -o jsonpath='{.spec.hard.requests\.memory}')
POD_LIMIT=$(kubectl get resourcequota compute-quota -n dev-namespace -o jsonpath='{.spec.hard.pods}')

if [ "$CPU_LIMIT" == "1" ] && [ "$MEM_LIMIT" == "1Gi" ] && [ "$POD_LIMIT" == "2" ]; then
  echo "Success: ResourceQuota is configured correctly!"
  exit 0
else
  echo "Error: ResourceQuota limits are incorrect. Please check your YAML."
  echo "Current: CPU=$CPU_LIMIT, Memory=$MEM_LIMIT, Pods=$POD_LIMIT"
  exit 1
fi
