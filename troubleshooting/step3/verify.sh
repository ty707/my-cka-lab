#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf

echo "Checking Service status, please wait..."
sleep 3 # 等待 3 秒让控制器生效

ENDPOINTS=$(kubectl get endpoints web-svc -n default -o jsonpath='{.subsets[0].addresses[0].ip}' 2>/dev/null)

if [ -z "$ENDPOINTS" ]; then
  echo "Error: Endpoints for web-svc is still empty."
  echo "Hint: Check if the Service Selector matches the Pod Labels."
  echo "You can use 'kubectl get pods -n default --show-labels' to check the correct labels."
  exit 1
fi

echo "Success: Service routing is restored. Endpoints bound to Pod IP: $ENDPOINTS"
exit 0
