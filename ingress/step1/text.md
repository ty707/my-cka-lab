请在 `default` 命名空间下创建一个名为 `my-ingress` 的 Ingress 资源。

**要求**：
1. 将 `app.example.com` 的流量转发到 `web-svc` 的 `80` 端口。
2. 将 `api.example.com` 的流量转发到 `api-svc` 的 `80` 端口。

<details>
<summary><b>👉 点击查看 Solution (参考答案)</b></summary>

**编写 YAML 文件 `ingress.yaml`：**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  namespace: default
spec:
  rules:
  - host: app.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-svc
            port:
              number: 80
  - host: api.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: api-svc
            port:
              number: 80
```

```bash

kubectl apply -f ingress.yaml
```
</details> 
