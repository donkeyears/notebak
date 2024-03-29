# sed用法总结

## 1. 简介

sed是一种流编辑器，非交互式。sed将要处理的文件以行为单位读入；将此行放入临时缓冲区；在缓冲区对流副本进行编辑；编辑后将结果送到标注输出。

## 2. 使用方法

首先定位要处理的行（定址），再操作（命令，选项），遵照正则表达式规则模糊搜索

**sed [address[,address]][!]{cmd}**

1. 定址

   sed选定要处理的行，由数字，正则，或二者结合确定。默认全部行

   ```
   sed -n '2p'  file	# 打印（p）第二行（2） 且输出处理行（-n）
   sed -n '100,200p'	# 100-200行
   sed '/my/,10d'		# 删除（d）包含my的行（/my/）到10行
   ```

2. 命令

   ```
   i 行之前插入，a 行之后插入。
   c 替换行，s 替换字符串
   d 行删除
   p 行打印
   g 行内全局替换
   
   ```

3. 选项

   ```
   -n 取消默认全部行输出，仅输出处理行
   -e 多项编辑，按顺序依次处理
   -f 指定输出文件
   -i 直接改动文件
   ```

4. 正则表达式

   ```
   ^ 行首 $ 行尾
   . 换行之外任意字符。 * 0个或任意  x\{m,n\} m-n个x 
   [a,b] 指定字符组a或b，[^a] 非a字符
   \(...\) 将括号内保存为标签。
   sed -n ‘1,20/\(your\)self/\1/g 将yourself替换为your
   ```

> [sed 简明教程，实例多](https://coolshell.cn/articles/9104.html)
>
> [sed 语法简介](https://www.cnblogs.com/edwardlost/archive/2010/09/17/1829145.html)

