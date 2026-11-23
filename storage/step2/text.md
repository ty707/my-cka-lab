# 🛠 任务二：注入高优先级调度属性 (PriorityClass)

为了防止核心数据库 Pod 在节点资源不足时被驱逐（Eviction）：

1. 创建一个名为 `high-priority` 的 PriorityClass，设定其 `value` 为 `1000000`。
2. 更新 `db-pod` 的配置，使其使用该 PriorityClass。
*(注：Pod 的优先级属性是不可变的，你需要先删除原有 Pod，再应用新的 YAML)*

<details>
<summary><b>👉 点击查看 Solution (参考答案)</b></summary>

**编写 `priority.yaml`：**
```yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 1000000
globalDefault: false
description: "High priority for critical database pods."
```

```bash

kubectl delete pod db-pod
```

</details>
