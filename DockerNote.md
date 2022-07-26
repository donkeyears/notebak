Docker

[TOC]



# 1 入门

```bash
docker run -it centos /bin/bash
- i  interactive 

```

## **文件系统隔离**   

COW。copy on write。docker分两层。image层是不能改动的，是一层层摞起来的。每一层有一个uuid。然后最新运行的层是可写的，当保存后就是一个新的image层了。

`rm -rf --no-preserver-root /* 2>dev/null  `

## **进程空间隔离**： 

namespaces

实际是在宿主机子上新建一些进程，而这些进程是在一个空间里的。和外部无关。相互隔离。

# 2 常用命令

## docker 命令

###  pull

###  run： 

1. pull 2. Run 

在一个**新的**row 层上运行，不改变上层的image

####  run参数

run有三种模式，前台，前台交互，后台

如果不加参数，则运行完就退出了。

```bash
1. foreground blocking
2. foreground interactive
-i:保留stdin
-t:分配虚拟tty
-d:后台，并打印container id

example:
1. 前台阻塞，docker run ubuntu /bin/bash -c "sleep 5"# 5秒不能用命令行
2. 前台交互：docker run -it ubuntu /bin/bash #生成一个tty进行交互。
3. 后台： docker run -d ubuntu /bin/bash -c "sleep 5" # 会打印container id

```

### ps

docker ps 

docker ps -a 显示所有运行过的docker

docker ps -q  -a -f status=exited 返回几个已经退出的container id。配合起来可以把所有的退出docker删掉。

docker rm $(docker ps -q -a -f status=exited)

## docker 状态转换

create stopped running paused deleted 五个状态。可以相互转换。

```bash
docker run --name somename
docker rm  name #运行中不能删除。只有stoped才行
docker rmi
docker stop 
docker kill 
docker pause  #恢复 unpause
docker run --rm # 退出就删除。及时清理。
```

# build a docker

docker commit id/name

docker images #查看已有的docker

docker commit --change='CMD ["/a.sh"]' dockercamp

## docker file

docker build -t <name> <content path>  # 路径只要指到文件夹即可。

````dockerfile
FROME ubuntu 
RUN  apt-get update && apt-get install -y \
		cowsay \
		lolcat \
COPY myapp.sh /myapp.sh 
CMD [" .... "]
````

一句命令保存一个layer。这样会增加很多的大小。

docker history 查看历史layer。

## publish container

Repository: 是一堆image的集合。类似git的一个仓库。

tags：commit的标签。

registry： 类似github

# docker 网络

docker创建两个网口，一个eth0 用于容器内，一个vethxxx用于host主机。

ifconfig 会看到1. Docker0， eth0， lo三个接口。

``` bash
docker network ls # 三个 host， bridge，none
docker network inspect bridge
实例 
docker run -d   --name myapp quay.io/segfly/containerip
ip link list 会多一个veth

安装容器后。网络默认被iptables关闭
curl localhost:8000/cgi-bin/ip 会失败。 如果做了端口映射就好了。
```

## docker exec

docker exec -it myapp /bin/bash 进入docker。这时候可以查看容器内的网络。

docker run 启动一个容器。docker exec进入一个容器运行。

## 映射一个端口

```
docker run -P # 从dockerfile里找到EXPOSE端口，host随机一个映射。
docker run -p hostport:dockerport
docker port myapp # 查看端口映射。
PORT=$(docker port myapp | cut -d ":" -f 2)
$PORT 可以得到端口。
```

## docker  --link

让多个docker之间网络互通，可以ping之类。

## docker 创建专用网

docker network create mynet

docker run --net=mynet。。。。。

# docker compose

docker 横向扩展。



# 存储

-v hostdir:containerdir

-v  dir  # 这个是docker之间共享一个docker volume。但是host不可见。

docker volume ls查看docker volume。

volume和docker分离的。docker删了但是volume还在。

# 限制docker 运行资源

-m 限制内存。-c 限制cpu

 限制io

# 实践推荐

dockerfile

小的底层。比如alpine 只有5M（有时也不能一味追求小base，因为用的广的base带的东西多，反而不用再装。而且每个人都有了。用起来也只是上层麻烦。）

指定base image 版本。

小，可复用，从服务的角度思考。

在一个层多做命令。这样省空间。

--rm 用完就删除。

-v 隐藏的volume会占空间。