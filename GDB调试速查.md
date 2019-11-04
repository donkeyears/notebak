# GDB调试速查

本文源于CSDN 陈皓。为了方便查询，根据自己理解简写方便查询。如需原文请看文末链接原文。

## 使用GDB

编译时添加-g参数。

启动方法；

> gdb prog
>
> Gdb prog core
>
> Gdb prog PID

## gdb 命令

gdb 命令可以不敲完全，敲打前几个字符也可以。且tab二次可以推荐输入。

gdb> shell command 执行shell命令。也可在gdb中直接使用make命令。

### gdb中运行程序

run之前可以：

1. set args 指定运行参数。show args查看参数。如gdb proga。其中正常运行时proga -f a.cpp.那么在gdb里可以"set args -f a.cpp" 然后再run就好了。
2. path dir 设定运行路径。 show paths。set env var=value 设定环境变量。show env 查看环境变量
3. cd pwd
4. info terminal

调试已运行程序。1. 查看pid开始前加上。2. 在gdb中attach。

### 暂停程序。

1. 断点 BreakPoints

   > b 	154
   >
   > b 	+5/-5 		#当前行号前后停止
   >
   > break a.cpp:144
   >
   > b 	b.cpp:main()
   >
   > b	*addr
   >
   > b	if i=100
   >
   > info b 2 		#查看二号断点

2. 观察点 WatchPoint

   观察点只在scope内有效。出了范围就会自动删除。7.4之后有watch -l可以增加有效期。否则观察地址解决。

   > watch expr 	#表达式expr***变化***时停住。
   >
   > rwatch expr	#表达式（变量）被***读取***时停住
   >
   > awatch expr	#表达式被**读/写**时停止
   >
   > info watch 

3. 捕捉点 CatchPoint
   捕捉点捕获程序运行事件(载入库，异常..)

   > gdb>catch event 	#event 可以是 throw，catch，exec/fork/(系统调用，目前仅在HP-UX)，load libname，unload libname。
   >
   > gdb> twatch		#只设置一次捕捉点。过后清除

4. 维护停止点

   > clear 	#清除  clear funa;  clear a.cpp:funa clear 145
   >
   > delete n #删除 第n个断点。可多个一起，可范围2-7
   >
   > disable n #暂停断点
   >
   > enable n #重新开始
   >
   > enable n once # 重新打开断点**一次** 

5. 停止条件维护

   b w可以带if条件。这个条件可以用condition修改

   > condition n expr #将第n个断点条件修改为expr
   >
   > cond n 	#清除断点条件
   >
   > ignore n 	#忽略断点n条件x次。

6. 为停止点设定运行命令

   断点停住后执行命令格式为 commands n.... end

   > break foo if x>0
   >
   > **commands**
   >
   > printf "x is d% /n",x
   >
   > continue
   >
   > **end**

7. 断点菜单 用于函数重载时，gdb提示具体在哪个函数断点。

8. 恢复 

   > continue 3 #继续并忽略之后三个断点。
   >
   > step #step in
   >
   > next # step over
   >
   > finish # 运行完函数并打印返回时堆栈地址和return值

9. 信号

   > handle SIGINT stop	 收到信号停止。handle sig action

10. 线程

    > info threads  #查看线程ID
    >
    > b 145 thread 5

### 查看堆栈信息。

> bt/backtrace #查看堆栈信息。
>
> bt 2 # 只查看上两层堆栈。
>
> frame 2 # 跳到第2层（0开始）
>
> frame #当前栈内容
>
> info frame
>
> info args
>
> info locals

- 查看源代码

  > list 145/funca
  >
  > list #显示之后的程序。 list - 显示之前的程序
  >
  > list beg，end  

- 搜索源代码 search regexp

- 指定源码路径。 dir ./source/a.cpp

- 查看源码内存。

  > info line test.c:func #显示代码片段内存地址。
  >
  > disassemble func #显示函数的汇编

- 查看运行时变量

有时编译会优化，所以个别内存无法访问也也正常。

> print /f expr # 以f格式输出expr
>
> p 'a.c'::x	# 某个文件中变量
>
> p *array@len #显示动态数组。

- 数据输出格式f 

  > x 16进制 d十进制 u十六进制无符号 o八进制 t二进制 c字符格式 f浮点数格式

- 查看内存examine/x

> x /nfu addr
>
> n f u 为可选参数。 
>
> n 为正整数，显示几个地址
>
> f 显示格式。参见上边f
>
> u 请求字节数 b单字节 h双字节，w四字节 g八字节
>
> x/3uh 0x54320 # 从0x54320 开始双字节（h）为单位读取三个单位，u十六进制无符号显示

- 自动显示

  > display /fmt expr #fmt 为格式
  >
  > undisplay n
  >
  > delete display n
  >
  > disable/enable/info display

### 设置显示项 略

### GDB环境变量 略

### 查看寄存器

> info registers

### 改变程序运行

1. 修改变量。print x=4 #修改变量x为4
2. 跳转执行 jump file:line 
3. 产生信号量
4. 强制函数返回
5. 强制调用函数。



> 1. [用GDB调试程序一,简介入门](<https://blog.csdn.net/haoel/article/details/2879>)
> 2. [二 断点类型](<https://blog.csdn.net/haoel/article/details/2880>)
> 3. [三断点的维护](<https://blog.csdn.net/haoel/article/details/2881>)
> 4. [四查看栈信息](<https://blog.csdn.net/haoel/article/details/2882>)
> 5. [五运行时数据](<https://blog.csdn.net/haoel/article/details/2883>)
> 6. 