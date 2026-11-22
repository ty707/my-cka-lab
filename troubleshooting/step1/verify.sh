#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf

# 检查 cpu requests 是否为 200m
if ! grep -q "cpu: 200m" /etc/kubernetes/manifests/kube-scheduler.yaml; then
  echo "错误：kube-scheduler 的 CPU requests 还未修改为 200m。"
  exit 1
fi

# 等待调度器启动
sleep 5
# 检查 Scheduler Pod 状态
SCHEDULER_STATUS=$(kubectl -n kube-system get pod -l component=kube-scheduler -o jsonpath='{.items[0].status.phase}')

if [ "$SCHEDULER_STATUS" != "Running" ]; then
  echo "提示：配置已改对，但 Pod 还没跑起来，请稍等 1 分钟后再次点击 CHECK。"
  exit 1
fi

echo "验证通过！Scheduler 已成功恢复运行。"
exit 0
