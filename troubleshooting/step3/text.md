# 排除网络故障
集群彻底恢复了，但是业务团队反馈：`default` 命名空间下的 `web-svc` 无法访问！使用 `curl` 访问该服务会超时或拒绝连接。

**你的任务**：
排查并修复 `web-svc` 无法访问的问题，确保其能够正常路由到后端的 `web-app` Pod。

<details>
<summary><b>👉 点击查看 Solution (参考答案)</b></summary>

**排错思路与修复步骤：**

1. **检查 Service 状态**：

    kubectl get svc web-svc -n default

2. **检查 Endpoints**：

    kubectl get endpoints web-svc -n default

如果发现 `ENDPOINTS` 为 `<none>`，说明 Service 的 Selector 没有匹配到任何 Pod。

3. **检查 Pod 的标签**：

    kubectl get pods -n default --show-labels

你会发现 `web-app` 的 Pod 标签是 `app=web-app`。

4. **检查 Service 的 Selector**：

    kubectl describe svc web-svc -n default

你会发现 Selector 被错误配置成了 `app=wrong-label`。

5. **修改 Service 的 Selector**：

    kubectl edit svc web-svc -n default

将 `spec.selector` 下的 `app: wrong-label` 改为 `app: web-app`。保存退出后，再次查看 Endpoints，应该就能看到正确的 Pod IP 了。
</details>
