# 🚨 紧急告警：控制平面通信中断

**业务场景：**
机房刚完成了一次物理机迁移，运维团队发现整个 K8s 集群处于“失联”状态。你尝试执行 `kubectl get nodes`，系统直接报错无法连接。

**你的任务**：
通过排查节点上的核心组件，定位并修复导致 API Server 崩溃的根本原因，恢复集群的通信。

> 💡 **排查提示**：控制平面组件是以静态 Pod 形式运行的，请检查它们的清单文件（Manifest）是否存在配置错误。

<details>
<summary><b>👉 点击查看 Solution (参考答案)</b></summary>

**排错思路：**

1. 既然 `kubectl` 报错，首先检查 `kube-apiserver` 的状态和日志，或者直接查看它的静态 Pod 配置文件。
2. 配置文件路径：`/etc/kubernetes/manifests/kube-apiserver.yaml`
3. 检查文件中关于 `etcd` 的连接配置：`--etcd-servers`
4. 发现配置被改为了错误的外部 IP（如 `11.0.1.111`），需要修改回本地地址。

**修复步骤：**

```bash
vim /etc/kubernetes/manifests/kube-apiserver.yaml
