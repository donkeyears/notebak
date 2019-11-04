# QOS quality of service

## qos

重要数据优先级要高，持续的语音包会和突发的数据包冲突。语音视频对时间敏感。

## 1. bandwidith

带宽是整个传输路径上的带宽。

Bmax=min（b1，b2，b3，。。。bn）整个路径的最小值。

Bavail = Bmax/flows

## 2. packet loss

路由器队列末尾丢包。很普通常见。

## 3 delay

路由器导致的delay 处理时间+排队时间+序列化时间（转化为比特流）+前进时间（处理好出路由器）

## 4. jitter

delay导致到达时间不确定。导致抖动