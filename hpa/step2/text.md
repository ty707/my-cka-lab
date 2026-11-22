# 模拟洪峰：触发自动扩容
配置已经生效，现在我们需要验证 HPA 是否真的在工作。请在右侧终端启动一个压测 Pod，向 `apache-server` 发起高并发请求。

**操作步骤**：
1. 启动压测 Pod（使用持续请求打满 CPU）：
```bash
kubectl -n autoscale run load-generator --image=busybox --restart=Never -- /bin/sh -c "while true; do wget -q -O- http://apache-server; done"
