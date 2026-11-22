#!/bin/bash
# 等待 K8s 完全启动
while [ ! -f /etc/kubernetes/manifests/kube-apiserver.yaml ]; do sleep 2; done
sleep 10

# 故障 1：修改 apiserver 的 etcd 地址 (把 127.0.0.1 改成错误的 IP)
sed -i 's|--etcd-servers=https://127.0.0.1:2379|--etcd-servers=https://11.0.1.111:6443|g' /etc/kubernetes/manifests/kube-apiserver.yaml

# 故障 2：修改 scheduler 的 CPU 请求
# 无论原本是 100m 还是 200m，直接改成 2000m (100%)
sed -i 's/cpu: 100m/cpu: 2000m/g' /etc/kubernetes/manifests/kube-scheduler.yaml
sed -i 's/cpu: 200m/cpu: 2000m/g' /etc/kubernetes/manifests/kube-scheduler.yaml

# 如果原文件里根本没有 cpu 这一行（防止一些特殊镜像），我们兜底直接改成 2000m
if ! grep -q "cpu: 2000m" /etc/kubernetes/manifests/kube-scheduler.yaml; then
    # 使用非常简单的替换，假设默认请求是 100m 或 200m 都在 requests 下面
    # 如果找不到，说明这个镜像的调度器配置比较特殊，直接不管它，后面的 step2 验证会报错，我们会看到
    echo "Warning: CPU line not found, nothing replaced."
fi

echo "初始化故障已完成！请稍候，等待组件自动重启..."
