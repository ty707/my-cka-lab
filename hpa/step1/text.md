在 `autoscale` 命名空间中，为已存在的 `apache-server` Deployment 创建一个名为 `apache-server` 的 HPA。

要求：
*   CPU 使用率目标：`50%`
*   最小 Pod 数：`1`
*   最大 Pod 数：`4`

**提示**：你可以使用 `kubectl autoscale` 命令，或者编写 YAML 文件。

```bash
# 尝试在这里输入你的命令
kubectl -n autoscale autoscale ...
