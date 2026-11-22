现在，请修改刚刚创建的 HPA，将**缩小稳定窗口（scaleDown stabilization window）**设置为 `30` 秒。

**提示**：
1. 使用 `kubectl edit hpa apache-server -n autoscale` 打开编辑器。
2. 在 `spec` 下添加 `behavior` 字段。
3. 你可以参考以下结构：

```yaml
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 30
