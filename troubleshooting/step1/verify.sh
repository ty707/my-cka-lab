#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf

# 检查 cpu requests 是否为 200m
if ! grep -q "cpu: 200m" /etc/kubernetes/manifests/kube-scheduler.yaml; then
  echo "Error: kube-scheduler CPU requests is not set to 200m."
  exit 1
fi

# 等待调度器启动
sleep 5
# 检查 Scheduler Pod 状态
SCHEDULER_STATUS=$(kubectl -n kube-system get pod -l component=kube-scheduler -o jsonpath='{.items[0].status.phase}')

if [ "$SCHEDULER_STATUS" != "Running" ]; then
  echo "Hint: Configuration looks correct, but the Pod is not running yet. Please wait 1 minute and click CHECK again."
  exit 1
fi

echo "Success"
exit 0
