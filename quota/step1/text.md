1. 创建一个名为 `dev-namespace` 的 Namespace。
2. 在 `dev-namespace` 中创建一个名为 `compute-quota` 的 ResourceQuota，要求：
   - 整个命名空间最多只能请求（requests） `1` 个 CPU 和 `1Gi` 的内存。
   - 整个命名空间最多只能创建 `2` 个 Pod。

<details>
<summary><b>👉 点击查看 Solution (参考答案)</b></summary>

**编写 `quota.yaml`：**
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: dev-namespace
---
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: dev-namespace
spec:
  hard:
    requests.cpu: "1"
    requests.memory: 1Gi
    pods: "2"
```

```bash
kubectl apply -f quota.yaml
```

</details>
