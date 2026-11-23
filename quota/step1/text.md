# 🛠 任务：实施命名空间资源配额

1. 创建一个名为 `dev-namespace` 的 Namespace。
2. 在该命名空间中创建一个名为 `compute-quota` 的 ResourceQuota，实施以下硬限制（Hard Limits）：
   - CPU 总请求量（requests.cpu）：最多 `1` 核。
   - 内存总请求量（requests.memory）：最多 `1Gi`。
   - Pod 总数：最多 `2` 个。

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
