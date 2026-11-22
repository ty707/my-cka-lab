#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf

# 检查 HPA 是否存在
if ! kubectl get hpa apache-server -n autoscale &> /dev/null; then
  echo "Error: HPA 'apache-server' not found in namespace 'autoscale'."
  exit 1
fi

# 检查 target CPU
TARGET_CPU=$(kubectl get hpa apache-server -n autoscale -o jsonpath='{.spec.metrics[0].resource.target.averageUtilization}')
if [ "$TARGET_CPU" != "50" ]; then
  echo "Error: HPA target CPU utilization is not set to 50%."
  exit 1
fi

# 检查 Min/Max
MIN_PODS=$(kubectl get hpa apache-server -n autoscale -o jsonpath='{.spec.minReplicas}')
MAX_PODS=$(kubectl get hpa apache-server -n autoscale -o jsonpath='{.spec.maxReplicas}')

if [ "$MIN_PODS" != "1" ] || [ "$MAX_PODS" != "4" ]; then
  echo "Error: HPA minReplicas or maxReplicas is incorrect. Expected: min=1, max=4."
  exit 1
fi

echo "Success: Verification passed! HPA is configured correctly."
exit 0
