# 🛠 任务：配置七层路由规则

请在 `default` 命名空间下，创建一个名为 `my-ingress` 的 Ingress 资源。

**路由规范**：
1. 拦截来自 `app.example.com` 的流量，将其路由至 `web-svc` 的 `80` 端口。
2. 拦截来自 `api.example.com` 的流量，将其路由至 `api-svc` 的 `80` 端口。
*(注：请严格遵循 Kubernetes `networking.k8s.io/v1` API 版本的规范)*

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
