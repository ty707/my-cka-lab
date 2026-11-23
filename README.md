# ☸️ CKA 云原生实战演练沙盒 (Killercoda)

这是一个基于开源交互式平台 **Killercoda** 构建的 Kubernetes 实战演练项目。旨在提供开箱即用的云端沙盒环境，模拟真实企业生产环境中的常见架构挑战与灾难恢复场景。

本项目的所有环境均由后端 Bash 脚本自动初始化（故障注入/资源创建），并提供基于 `kubectl jsonpath` 的自动化判卷脚本 (`verify.sh`)，为学习者提供秒级反馈。

## 🔗 在线体验直达

点击下方链接即可在浏览器中一键启动实战环境（无需配置本地集群，免费体验）：

### 🟢 核心实战篇
*   [**实验一：HPA 高并发流量下的自动弹性伸缩**]
    *   模拟电商大促洪峰，手写 HPA YAML 并结合 BusyBox 发起真实压测，观察 Pod 自动扩容。
    *   *核心技术：HPA, Metrics Server, Load Testing*
*   [**实验二：K8s 控制平面连环灾难恢复**]
    *   模拟机房迁移导致的 API Server (etcd)、Scheduler (资源溢出) 及 Service (路由断裂) 三连击故障。
    *   *核心技术：Static Pods, Troubleshooting, Service & Endpoints*

### 🔵 进阶运维篇
*   [**实验三：Ingress 流量路由与网关配置**]
    *   配置基于域名的 Ingress 规则，实现统一入口与南北向流量分发。
    *   *核心技术：Ingress, Ingress Controller*
*   [**实验四：RBAC 最小权限隔离实战**]
    *   为开发团队创建专属 ServiceAccount，配置 Role 和 RoleBinding 实现权限隔离。
    *   *核心技术：RBAC, ServiceAccount, 最小权限原则*
*   [**实验五：持久化存储与 Pod 优先级调度**]
    *   配置 PVC 持久卷保障数据不丢失，并通过 PriorityClass 保障核心业务 Pod 不被驱逐。
    *   *核心技术：PVC, PV, PriorityClass, 调度策略*
*   [**实验六：ResourceQuota 命名空间资源治理**]
    *   为特定 Namespace 设置资源配额限制，防止团队过度占用集群资源。
    *   *核心技术：ResourceQuota, Namespace Isolation*

---

## 💡 项目工程化亮点

1.  **生产级故障注入（Chaos Engineering）**：利用后台 Shell 脚本，精准模拟各类故障（如篡改 etcd 配置、错误配置 Service Selector），高度还原 CKA 认证考试与真实运维场景。
2.  **自动化判卷逻辑（Auto-Grading）**：独立编写 `verify.sh` 脚本，熟练使用 `kubectl jsonpath` 和 `kubectl auth can-i` 等命令，对资源状态、CPU 指标、权限边界进行精准的二次校验。
3.  **SRE 级产品化体验**：
    *   纯英文终端输出，彻底规避跨平台终端编码乱码风险。
    *   全中文图文教程，支持 Markdown `<details>` 折叠参考答案，不剧透。
    *   每个实验结尾附带详细的 **SRE 复盘报告 (Post-mortem)**，授人以渔。

---

## 🛠️ 技术栈

`Kubernetes` | `Docker` | `Bash Scripting` | `Markdown` | `Killercoda` | `GitHub Webhooks`

---

## 📂 仓库结构

*   `/hpa`：HPA 自动扩缩容实战
*   `/troubleshooting`：集群核心组件故障排查
*   `/ingress`：Ingress 流量路由
*   `/rbac`：权限隔离与安全配置
*   `/storage`：持久化存储与调度
*   `/quota`：资源配额管理
