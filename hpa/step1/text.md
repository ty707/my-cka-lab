# 业务背景
你的团队刚刚上线了一个基于 Nginx 的 `apache-server` 服务，目前部署在 `autoscale` 命名空间下。
为了应对即将到来的大促流量，你需要为该服务配置 HPA 自动扩缩容，保证服务不崩溃，同时节省成本。

# 你的任务
请**不要**使用 `kubectl autoscale` 快捷命令，而是**手写一个 YAML 文件** 来创建 HPA。

要求如下：
1. HPA 名称：`apache-server`
2. 目标 Deployment：`apache-server`
3. 当 CPU 平均使用率达到 `50%` 时触发扩容。
4. 最少保留 `1` 个副本，最多不超过 `4` 个副本。

创建完成后，使用 `kubectl get hpa -n autoscale` 检查状态，点击 CHECK 验证。
