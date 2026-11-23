1. 创建一个名为 `my-pvc` 的 PVC，要求 `storageClassName` 为 `local-path`（默认），请求 `1Gi` 的存储空间。
2. 创建一个名为 `db-pod` 的 Pod，镜像使用 `nginx:alpine`，将 PVC 挂载到容器的 `/data` 目录。

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
