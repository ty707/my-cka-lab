# 🔒 架构挑战：零信任与多租户隔离

**业务背景**：
在共享的 K8s 集群中，安全边界必须被严格定义。近期安全审计团队发现，开发人员使用的 ServiceAccount 拥有过高权限（甚至能删除核心 Pod），这严重违反了“最小权限原则 (Principle of Least Privilege)”。

**你的目标**：
你需要为开发团队创建一个专用的 `ServiceAccount`，并基于 RBAC (基于角色的访问控制) 模型，为其精准分配只读（Read-Only）权限，实现安全隔离。
