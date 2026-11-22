API Server 恢复后，你敲 `kubectl get nodes` 应该能看到节点是 `Ready` 的。

但是，如果你执行 `kubectl -n kube-system get pod`，你会发现 **`kube-scheduler-master01` 这个 Pod 的状态是 `ContainerStatusUnknown` 或者是 `CrashLoopBackOff` 或者干脆没起来**。

**你的任务**：
修复所有损坏的集群组件的配置。

```bash
vim /etc/kubernetes/manifests/kube-scheduler.yaml
