#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf

# 检查 stabilizationWindowSeconds 是否被设置成了 30
WINDOW=$(kubectl get hpa apache-server -n autoscale -o jsonpath='{.spec.behavior.scaleDown.stabilizationWindowSeconds}')

if [ "$WINDOW" == "30" ]; then
  echo "验证通过！缩容窗口已成功设置为 30 秒。"
  exit 0
else
  echo "错误：缩容窗口设置不正确。当前值为: $WINDOW"
  exit 1
fi
