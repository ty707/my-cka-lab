#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf

# 检查 SA 是否存在
if ! kubectl get sa dev-sa &> /dev/null; then
  echo "Error: ServiceAccount 'dev-sa' not found."
  exit 1
fi

# 检查 Role 的权限
ROLE_VERBS=$(kubectl get role pod-reader -o jsonpath='{.rules[0].verbs[*]}')
if [[ "$ROLE_VERBS" != *"get"* ]] || [[ "$ROLE_VERBS" != *"list"* ]]; then
  echo "Error: Role 'pod-reader' does not have the correct verbs (get, list, watch)."
  exit 1
fi

# 使用 kubectl auth can-i 验证权限隔离
# 模拟该 SA 的身份去尝试获取 Pod（应该成功）
CAN_GET=$(kubectl auth can-i get pods --as=system:serviceaccount:default:dev-sa)
# 模拟该 SA 的身份去尝试删除 Pod（应该失败）
CAN_DELETE=$(kubectl auth can-i delete pods --as=system:serviceaccount:default:dev-sa)

if [ "$CAN_GET" == "yes" ] && [ "$CAN_DELETE" == "no" ]; then
  echo "Success: RBAC configuration is correct. Least privilege verified!"
  exit 0
else
  echo "Error: RBAC permissions are not correct. Ensure 'dev-sa' can get but NOT delete pods."
  exit 1
fi
