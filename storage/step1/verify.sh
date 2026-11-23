#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf

# 检查 PVC 是否存在且绑定
PVC_STATUS=$(kubectl get pvc my-pvc -o jsonpath='{.status.phase}')
if [ "$PVC_STATUS" != "Bound" ]; then
  echo "Error: PVC 'my-pvc' is not bound. Current status: $PVC_STATUS."
  exit 1
fi

# 检查 Pod 是否存在并挂载了 PVC
if ! kubectl get pod db-pod &> /dev/null; then
  echo "Error: Pod 'db-pod' not found."
  exit 1
fi
CLAIM_NAME=$(kubectl get pod db-pod -o jsonpath='{.spec.volumes[0].persistentVolumeClaim.claimName}')
if [ "$CLAIM_NAME" != "my-pvc" ]; then
  echo "Error: Pod 'db-pod' is not using PVC 'my-pvc'."
  exit 1
fi

echo "Success: PVC is bound and mounted to the Pod correctly!"
exit 0
