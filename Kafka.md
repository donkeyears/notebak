# Kafka

## 消息队列产生的需求

比如取快递，消费者和快递员都很忙，谁也不会等谁，那么就需要一个中间商(比如丰巢，菜鸟)来去缓存消息。快递员把快递放在丰巢，然后消费者有空的时候去取件。这样彼此都可以各忙各的。这个丰巢就是一个消息队列，快递员是生产者，消费者就是消费者。生产者在需要的时候把消息放在消息队列，生产者在空闲时去处理消息，消息被处理后就没了。当过期后也会被清理。

好处：

1. 解耦：生产者消费者都不用等待对方
2. 异步：无需等待。
3. 削峰：消息队列可以处理多种类型消息。

### 消息队列模式

1. 点对点。消息队列收到消息后不处理，消费者主动去取。
2. 发布订阅：消息队列通知消费者取取。

## Kafka 结构

### kafka架构及术语

1. producer： 生产者，消息入口
2. Broker： kafka的一个实例。
3. topic：消息的主题。可以认为消息的分类。比如统计用户信息。
4. Partition ：topic的分区，每个topic可以有多个分区，分区可以做负载，提高topic的吞吐。**同一个topic在不同partition不重复**， 比如100个消息，可以分成5个paritition分别取存储。这样可以5个线程分别去做。
5. replication： 每一个分区都有多个副本，副本作用是做备胎，当主分区Leader故障，会从备胎Follower选择一个成为Leader。就是在不同的broker分别存放副本，提高可用性。
6. Message：发送消息的主体。
7. Consumer：消费者，消息出口
8. consumer Group：多个消费者组成一个消费者组。同一个分区只能被一个消费者组中的一个消费者消费。一个消费者可以消费不同分区。
9. ZooKeeper：保存集群元信息。保证可用性。

### 工作流程

### 发送数据

生产者将要存的消息分别放入不同的分区。分区名为Topicname_partitionName. partition在物理上就是一个文件夹。

每个分区partition由多个段 segment。每个segment大小恒定，但是里边消息数目不一定，因为消息大小在变。

每个segment中是一个个的消息顺序存储。比如msg 1-100按顺序存下去。由于顺序存取机械硬盘速度比内存还快。这时高速的根源。

每个segment有三个文件 .index .log	.timeindex三个文件。log存message。index存索引。文件名前边为segment中最小offset。比如第一个log存了msg 0-15. segment2中的log存了msg 16-50.那么log名字分别为 0.log   15.log 51.log .三个segment大小相等，log数字递增。这样后期查找可以先根据seg名字快速索引。

### 消费数据。

快速找到msg。 首先找到seg段，比如msg40就取第二个segment。然后从seg2 的index去寻找消息。seg2 index使用稀疏索引。就是索引只保存了 15，25，35，45的开始位置，那么我们从35开始找到文件，很快就找到了msg40.

索引利用segment+有序offset+稀疏索引+二分查找+顺序查找。快速定位数据。





> [kafka 数据可靠性深度解读](<https://www.jianshu.com/p/b37beff657f3>)
>
> [基本原理，再过半小时，你就能明白kafka的工作原理了](<https://zhuanlan.zhihu.com/p/68052232>)
>
> [kafka 系列解析](<https://www.cnblogs.com/jasongj/p/7912348.html>)
>
> [kafka 架构介绍](<https://www.infoq.cn/article/kafka-analysis-part-1>)

