linux 文件系统

磁盘是由一个个扇区组成。扇区组成一个圆就是磁柱，磁柱是分partion的基础。

文件系统一个区块群组有：superblock，文件系统描述符，block bitmap，inode bitmap， inode table，data block。

分区后需要格式化为某个文件系统。文件系统记录了文件怎么存储。可以有supernode，inode和datablock。superblock记录文件系统的相关信息（inode block总量用量剩余量，以及文件系统格式等）。bitmap记录了是否使用。inode为索引（文件属性及对应block号码），block为具体数据。

目录的block记录了该目录下的文件的inode

将文件系统与目录树关联叫做挂载。挂载点一定是目录，该目录为进入文件系统的入口。

挂载，把***文件系统***挂到***目录树***上。文件系统为某个格式化的磁盘。目录树为一层层目录

定位/etc/passwd过程：

1. 根据挂载点信息找到inode为2的根目录inode，inode权限合格，可以读取/下block
2. 根据1的block中表格找到 /etc文件名和inode
3. 根据上一个inode，有权限，则可读取其block，block中有/etc目录下inode与名称
4. 找到passwd的inode，读取其block内容。

查看的命令

df直接读取superblock信息。比较迅速。

du文件系统去搜寻，所以速度慢一些，du现实当前目录下的目录大小（会把目录及目录下的目录都显示。如在/下执行，连/home/a的文件夹大小都会显示），du -a加上文件。

## 磁盘操作

1. 磁盘分割为分区partition
2. 对分区进行格式化，产生文件系统
3. 创建挂载点（目录），将其挂在上来。

分区（fdisk），格式化（mkfs），挂载（mount）

fdisk对磁盘进行分区。

```

fdisk /dev/hda  #注意没有分区。hda就是第一块硬盘。hda1为分区了。
m帮助，p显示当前分区。d删除一个分区。n添加一个分区。
mkfs -t ext3 /dev/hda1   # 对分区一格式化为ext3
mount /dev/hdc6 /mnt/hdc6   把hdc的第六个分区挂到/mnt/hdc6下。就是给硬盘支配一个目录树的点。
unmount /dev/hdc6
```

### 挂载

挂载点是目录，这个目录是进入分区的入口。

注意：1. 一个FS不应使用多个挂载点。2. 一个挂载点不应挂载多个FS，3. 挂载点目录理论上要空目录。

