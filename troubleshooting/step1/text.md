由于 `kube-apiserver` 的 etcd 地址被改错，现在集群已经挂掉了，`kubectl get nodes` 肯定会报错。

**你的任务**：
修复所有损坏的集群组件的配置

```bash
# 提示：使用 vim 编辑
vim /etc/kubernetes/manifests/kube-apiserver.yaml
