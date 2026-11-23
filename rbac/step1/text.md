# 🛠 任务：实施 RBAC 权限收敛

请在 `default` 命名空间下，实施以下安全管控策略：

1. 创建服务账号：`dev-sa`。
2. 创建角色（Role）：`pod-reader`，仅允许对 Pod 资源执行 `get`、`list`、`watch` 操作（严禁包含 `delete` 或 `create`）。
3. 创建角色绑定（RoleBinding）：`read-pods`，将上述 Role 绑定到 `dev-sa`。

<details>
<summary><b>👉 点击查看 Solution (参考答案)</b></summary>

**编写 YAML 文件 `rbac.yaml`：**
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: dev-sa
  namespace: default
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: ServiceAccount
  name: dev-sa
  namespace: default
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

```bash

kubectl apply -f rbac.yaml
```
</details> 
