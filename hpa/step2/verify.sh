#!/bin/bash
export KUBECONFIG=/etc/kubernetes/admin.conf

# 1. 获取当前实际的可用副本数
CURRENT_REPLICAS=$(kubectl get deploy apache-server -n autoscale -o jsonpath='{.status.readyReplicas}')
# 容错处理：如果还没准备好，可能是空的
if [ -z "$CURRENT_REPLICAS" ]; then
    CURRENT_REPLICAS=0
fi

# 2. 获取当前 CPU 使用率
CURRENT_CPU=$(kubectl get hpa apache-server -n autoscale -o jsonpath='{.status.currentMetrics[0].resource.current.averageUtilization}')

# 如果 CPU 指标还没出来，直接失败并给提示
if [ -z "$CURRENT_CPU" ]; then
    echo "Error: Metrics Server has not collected CPU data yet."
    echo "Hint: Ensure the load generator is running, and wait 1-2 minutes."
    exit 1
fi

# 3. 核心判断：必须副本数 > 1，并且 CPU 指标 >= 50
if [ "$CURRENT_REPLICAS" -gt 1 ] && [ "$CURRENT_CPU" -ge 50 ]; then
    echo "Success: Verification passed!"
    echo "Current CPU usage: ${CURRENT_CPU}% (exceeds target 50%)"
    echo "Current replicas auto-scaled to: $CURRENT_REPLICAS"
    echo "Your HPA configuration is perfect!"
    exit 0
else
    echo "Error: Verification failed."
    echo "Current state: CPU usage ${CURRENT_CPU}%, Replicas ${CURRENT_REPLICAS}."
    echo "Hint:"
    echo "1. Make sure the load generator from step2 is running."
    echo "2. HPA scaling takes time. Please wait 1-2 minutes and click CHECK again."
    exit 1
fi

