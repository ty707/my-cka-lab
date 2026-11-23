请在 `default` 命名空间下完成以下配置：

1. 创建一个名为 `dev-sa` 的 ServiceAccount。
2. 创建一个名为 `pod-reader` 的 Role，允许对 Pod 进行 `get`、`list`、`watch` 操作。
3. 创建一个名为 `read-pods` 的 RoleBinding，将上述 Role 绑定到 `dev-sa`。

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
