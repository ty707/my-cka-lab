# 🌐 业务场景：统一流量入口
你的团队部署了 `web-svc` 和 `api-svc` 两个服务。为了节省公网 IP，架构师要求使用 Ingress 作为统一入口，
将 `app.example.com` 的流量转发到 `web-svc`，将 `api.example.com` 的流量转发到 `api-svc`。

*(注：后台已自动为你部署好这两个 Service 和 Ingress Controller)*
