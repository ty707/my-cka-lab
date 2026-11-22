# ⚠️ 连锁故障：节点资源调度异常

**业务场景：**
API Server 恢复通信后，你执行 `kubectl get nodes` 发现节点显示 `Ready`。但是，业务团队反馈新建的 Pod 一直处于 `Pending` 状态。
进一步排查发现，`kube-system` 命名空间下的 `kube-scheduler` 组件状态异常（如 `ContainerStatusUnknown` 或未运行）。

**你的任务**：
检查并修复调度器（Scheduler）的配置，使其能够正常运行。

> 💡 **排查提示**：调度器也是静态 Pod，请检查它的资源配置是否超过了节点的实际物理容量。

<details>
<summary><b>👉 点击查看 Solution (参考答案)</b></summary>

**排错思路：**

1. 查看静态 Pod 清单：`/etc/kubernetes/manifests/kube-scheduler.yaml`
2. 重点检查 `resources` 字段下的 `requests.cpu`。
3. 发现 CPU 请求被设置成了 `2000m`（即 2 个核心）。如果节点仅有 2 个 CPU 核心，调度器本身就会因为资源不足而无法启动。
4. 修改为合理的值（如 `200m`）。

**修复步骤：**

```bash
vim /etc/kubernetes/manifests/kube-scheduler.yaml
