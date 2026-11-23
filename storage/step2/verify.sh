#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf

# 检查 PriorityClass 是否存在
if ! kubectl get priorityclass high-priority &> /dev/null; then
  echo "Error: PriorityClass 'high-priority' not found."
  exit 1
fi

# 检查 Pod 的优先级字段
PRIORITY_NAME=$(kubectl get pod db-pod -o jsonpath='{.spec.priorityClassName}')
if [ "$PRIORITY_NAME" != "high-priority" ]; then
  echo "Error: Pod 'db-pod' is not using PriorityClass 'high-priority'."
  exit 1
fi

echo "Success: PriorityClass is configured correctly!"
exit 0
