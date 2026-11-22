# 🚀 CKA 云原生实战演练沙盒 (Killercoda)

欢迎！这是一个基于开源交互式平台 **Killercoda** 构建的 Kubernetes 实战演练项目。项目旨在模拟真实生产环境中的高并发压测与灾难恢复场景，提供开箱即用的云端沙盒环境。

## 🔗 在线体验直达

点击下方链接即可在浏览器中一键启动实战环境（无需配置本地集群，秒级拉起）：

*   [**实验一：HPA 高并发流量下的自动弹性伸缩**](https://killercoda.com/kube-master/scenario/hpa) *(注：请将链接替换为你真实生成的链接)*
    *   **场景**：模拟双十一流量洪峰，手写 YAML 创建 HPA，并通过 Busybox 发起真实 HTTP 压测，观察 Pod 自动扩容。
    *   **核心技术**：`HorizontalPodAutoscaler`, `Metrics Server`, `Load Testing`。

*   [**实验二：K8s 控制平面连环灾难恢复**](https://killercoda.com/kube-master/scenario/troubleshooting) *(注：请将链接替换为你真实生成的链接)*
    *   **场景**：模拟机房迁移导致的 API Server etcd 失联、Scheduler 资源溢出宕机，以及 Service 路由断裂的三连击故障。
    *   **核心技术**：`Static Pods`, `kube-apiserver`, `kube-scheduler`, `Service & Endpoints`。

---

## 💡 项目核心亮点

1.  **纯手工硬核排错**：不依赖现成脚本，要求用户直接排查宿主机上的静态 Pod (Manifest) 配置，高度还原 CKA 认证考试环境。
2.  **真实的压测与自动化判卷**：HPA 实验引入了真实的流量压测，`verify.sh` 采用 `jsonpath` 提取当前副本数与 CPU 使用率，进行双重逻辑校验，防止作弊。
3.  **SRE 级产品化体验**：
    *   题库全部采用 Markdown 编写，支持 `<details>` 折叠参考答案，避免直接剧透。
    *   底层 `verify.sh` 脚本的终端反馈全部采用纯英文输出，规避了跨平台终端的编码乱码风险。
    *   包含详细的 **SRE 复盘报告 (Post-mortem)** 结尾，授人以渔。

---

## 🛠️ 技术栈

`Kubernetes` | `Docker` | `Bash Scripting` | `Markdown` | `Killercoda API` | `GitHub Webhooks`

---

## 📂 仓库结构说明

*   `/hpa`：HPA 自动扩缩容实验场景（包含配置、题目与验证脚本）。
*   `/troubleshooting`：K8s 故障排查实验场景（包含故障注入、题目与验证脚本）。
