## 系统架构演进

1. 单数据库-> B/S-> web browser user 

k8s利用容器（如docker）管理云平台。集群管理，作业调度。服务注册，服务发现。

# 1 容器技术

Docker 

基于 cgroup分配资源 namespce做隔离

优势，无中间系统开销

namespace: PID，network，ipc，mount， user 隔离。

Union Fs







```bash
docker run -d
docker inspect 查看docker网络内容
docker exec -it **** sh

docker inspect -9898aefb8dl... |grep -i pdi
nsenter ..查看网络的配置进程

lsns -t net 查看 网络的namespace
cd /proc/4311/

k delete deploy nginx

```













kubectl get po -n istio-system

kubectl describe po istio-init-crd-12-release-1.3-latest-daily-nstrx -n istio-system

kubectl describe po istio-init-crd-12-release-1.3-latest-daily-nstrx -n istio-system

helm install istio-init install/kubernetes/helm/istio-init  --namespace istio-system

helm uninstall istio-init

helm release

helm list

kubectl get po -n istio-system

kubectl delete deploy





kubectl get clusterrole istio-init-istio-system

kubectl delete clusterrole istio-init-istio-system

