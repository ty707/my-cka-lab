# 🛠 任务一：配置持久化存储挂载

1. 创建一个名为 `my-pvc` 的 PVC，请求 `1Gi` 存储空间（使用集群默认 StorageClass）。
2. 创建一个名为 `db-pod` 的 Pod（镜像 `nginx:alpine`），将 `my-pvc` 挂载至容器的 `/data` 目录。

<details>
<summary><b>👉 点击查看 Solution (参考答案)</b></summary>

**编写 `storage.yaml`：**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: db-pod
spec:
  containers:
  - name: db
    image: nginx:alpine
    volumeMounts:
    - mountPath: "/data"
      name: my-storage
  volumes:
  - name: my-storage
    persistentVolumeClaim:
      claimName: my-pvc
```

</details>
