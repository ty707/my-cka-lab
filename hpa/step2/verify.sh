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
    echo "❌ 验证失败：Metrics Server 还没采集到 CPU 数据。"
    echo "💡 提示：请确认是否执行了压测命令，并耐心等待 1-2 分钟。"
    exit 1
fi

# 3. 核心判断：必须副本数 > 1，并且 CPU 指标 >= 50
if [ "$CURRENT_REPLICAS" -gt 1 ] && [ "$CURRENT_CPU" -ge 50 ]; then
    echo "✅ 验证通过！"
    echo "🔥 当前 CPU 使用率为 ${CURRENT_CPU}% (已超过目标值 50%)"
    echo "📈 当前副本数已自动扩容至 $CURRENT_REPLICAS 个。"
    echo "🎉 你的 HPA 配置非常完美！"
    exit 0
else
    echo "❌ 验证失败。"
    echo "当前状态：CPU 使用率 ${CURRENT_CPU}%，副本数 ${CURRENT_REPLICAS}。"
    echo "💡 提示："
    echo "1. 请确认是否执行了 step2 的压测命令。"
    echo "2. HPA 扩容需要时间，请等待 1-2 分钟后再点击 CHECK。"
    exit 1
fi
