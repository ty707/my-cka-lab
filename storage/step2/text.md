现在，请确保数据库 Pod 具有高优先级。
1. 创建一个名为 `high-priority` 的 PriorityClass，设定其值为 `1000000`。
2. 修改 `db-pod` 的配置，使其使用这个 PriorityClass。
*(提示：Pod 的 PriorityClass 不可直接修改，可以删除原 Pod 后重建)*

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
