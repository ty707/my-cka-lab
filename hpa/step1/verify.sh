```bash
#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf

# 检查 HPA 是否存在
if ! kubectl get hpa apache-server -n autoscale &> /dev/null; then
  echo "Error"
  exit 1
fi

# 检查 target CPU
TARGET_CPU=$(kubectl get hpa apache-server -n autoscale -o jsonpath='{.spec.metrics[0].resource.target.averageUtilization}')
if [ "$TARGET_CPU" != "50" ]; then
  echo "Error"
  exit 1
fi

# 检查 Min/Max
MIN_PODS=$(kubectl get hpa apache-server -n autoscale -o jsonpath='{.spec.minReplicas}')
MAX_PODS=$(kubectl get hpa apache-server -n autoscale -o jsonpath='{.spec.maxReplicas}')

if [ "$MIN_PODS" != "1" ] || [ "$MAX_PODS" != "4" ]; then
  echo "Error"
  exit 1
fi

echo "Success"
exit 0
