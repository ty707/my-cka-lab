#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf

echo "正在检查 Service 状态，请稍候..."
sleep 3 # 等待 3 秒让控制器生效

ENDPOINTS=$(kubectl get endpoints web-svc -n default -o jsonpath='{.subsets[0].addresses[0].ip}' 2>/dev/null)

if [ -z "$ENDPOINTS" ]; then
  echo "❌ 验证失败：web-svc 的 Endpoints 依然为空。"
  echo "💡 提示：请检查 Service 的 Selector 是否与 Pod 的 Labels 匹配。"
  echo "你可以用 'kubectl get pods -n default --show-labels' 查看正确标签。"
  exit 1
fi

echo "✅ 验证通过！Service 修复成功，Endpoints 已成功关联到 Pod IP: $ENDPOINTS"
exit 0
