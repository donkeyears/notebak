# expect 注意事项

shell环境的一个优点是可以自动化，一些重复，循环使用的命令完全可以由自动化脚本去执行。但是简单的eshell脚本只是简单的主动去执行，而没有去管标准输出的反馈信息。如何去处理反馈呢？这时候expect就有了用武之地。

expect是Don Libes在1990年创造。是一个实现自动化交互的软件。主要由四个命令组成：

expect，接收进程字符串

send，发送指定字符串

spawn，产生一个新的进程进行交互

interact。允许用户进行交互。

expect和send是expect的精髓，一种模式-动作进行交互，接收某些条件的输入，进行对应的操作。类似于

```
expect "hi"
send "hello \r"
```

一来一往，循环往复。自动交互。

expect 可以理解为一种特殊shell，如果想写成脚本，则要在文件开头写上执行文件位置

```shell
#!/usr/bin/expect
```

## bash执行expect脚本

1. 使用expect -c “...”  注意…中的expect脚本双引号要使用转义符号\

   ```bash
   expect -c "
   	expect \"a\"
   	send \"b\"
   "
   ```

2. 使用hello document()的嵌套模式

   ```
   #!/bin/bash
   echo "123"
   /usr/bin/expect <<EOF　　#利用here document的expect代码嵌套
   # expect 会将命令开头到输入EOF之间的内容作为expect的参数。
   spawn ssh root@172.16.11.99
   expect "*password:"
   send "rootzhang\r"
   expect "*#"
   send "touch zhangjiacai\r"
   expect "*#"
   send "exit\r"
   expect eof　　#捕获结束  这句必须加上才可以
   #EOF之内的变量为bash的变量。不是set的。！！！！
   
   EOF  
   ```

## 多分支判断

注意：

expect和{之间要有空格，

下面每一行前边不能用tab，只能用空格。

exp_continue 后边会继续等待。

最后加上interact允许用户进入交互。否则你如论输入什么都没有回复。

```
expect {
　　"hi" { send "You said hi\n"; exp_continue}
　　"hello" { send "Hello yourself\n"; exp_continue}
　　"bye" { send "That was unexpected\n"}
}
interact
```

