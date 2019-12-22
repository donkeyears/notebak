# python note

## 1. 基本数据结构

>- **int** (for integer)
>- **float**
>- **str** (for string)
>- **list**
>- **tuple**
>- **dict** (for dictionary)
>- **set**
>- **bool** (for Boolean True/False)

**python 是动态类型** 也就是变量a的类型可以不断的变化。可以为数字，也可以为字符串。所以每次用之前最好检查类型。

```python
小数除法 3/2=1.5; 
整数除法7//4=1 ;
求余 7%4 = 3; 
立方 2**3 = 9
string a="helloworld"
a[1:5:2] 从1开始到5结束，每2为一个步进。
a[-1] 从末尾往前走。这儿为‘d'.
'tinker'[1:4] ='ink' 1为i。4不包含。
'hello'[::-1] -> olleh **倒序**排列了
```

字符串被赋值后，其内容不可更改。

比如a='hello' a[0]='i'会报错。因为a不可以被更改

### 字符串加减乘除。

a=‘z'  a*2为'zz'

字符串函数

``` python
x='python'; x.upper(); x.lower();x.split('i')用i分隔开
```

### 字符串打印格式化

1. %d c语言方式；2. format函数，3. f string

```python
print("hello %s" % "world")
print("hello {}".format("world"))
print("hello {1}".format('asdf',"world"))
print("hello {w}".format('asdf',w="world"))
print("hello {r:width.precion f}".format(r=100/777))# 宽度w，小数点后精确度p
name='sam'; age=3 print(f"{name} is {age} years old") #f string
num=23.56
print(f'{num:{10}.{6}}') 23.56 十位，六位有效数字。但是56后边0不补。
print(f'{num:10.4f}') fstring中也可以用老的format格式。这儿就是23.5600 4为小数点后位数，会补0
```

fstring只在python3.6之后有。

format()函数里写出了{}位置应该填写的内容。{}

### list

list可以是不同类型的放在一起。mylist = ["a",1,1.5]

list可以相加。list的一个位置可以用修改。和string不一样。list[0]= a; 合法。

list append()在后边添加。list pop把最后一个弹出并删除。

pop(1) 删掉第2个元素

list.sort() 内部排序替换。但是**不返回** 

list.reverse()逆序排序

### dictorary

d = { 'key1':'value1', 'key2':'value2'} key-value 结构，无序

d添加一个新的key。 d[newkey] = value

d.keys()返回各个key。d.values()返回所有value。

### tuple

tuple 和list和相似。但是tuple用（），list use []。

t=（1，2，3）

t.count("a") a出现次数。t.index 返回位次。tuple只有这两个方法。

**tuple 值不可以改变**！！！

### sets

无序元素的组合。元素不会重复。

```
myset= set()
myset.add(1)
myset.add('a')
```

### File

```
%%writefile mytest.txt
llllll

myfile = open('mytest.txt')
myfile.read() # read the file and output with \n
myfile.readlines() # 把换行等解析。也就是显示上解析好。并放在一个list里。一行一个元素
myfile.seek(0) # 重置读取位置。
myfile.close()
```

文件的读取模式，r，w（overwrite），a（append），r+， w+

```python
with open('a.txt', mode='a') as f:
    f.write('\nwaht are you')
```

### 比较运算符

==, >= ,<=, !=

2.0== 2. **True** 

and or not 逻辑运算

### control flow。基本语法

1. if else注意冒号，注意缩进

```python
if condition :
    a
elif cond:
    b
else:
```

2. for for后边可以跟各种集合，有序无序都可以。可以用map list

```python
mytable= [1,2,3]
for myitem in mytable:# 如果这儿mytable是一个map，则打印的只有key
    print(myiter)
mylist = [(1,2),(3,4)]
for a,b in mylist:#只打印b，可以解绑定。
    print(b)
```

3. while 

```python
while cond:
	dosome
else:
    dosomeother
    
循环内部，break，continue，pass（什么也不做，占位）
```

### 常用函数

range 

```bash
1. range(stop) range(10)区间[0,10)
rangee(start,stop,step)

2. word = "abcde"
for item in enumerate(words) ：
	print(item)
输出(0,a) (1,b).... 自动生成了多个tuple

3. zip函数，把多个list转秩，并合并。
[1,2] [a,b]合并后成了（1，a) (2,b)
zip只会取最短的list

4. 2 in [1,2,3]   True
a in "a world" True
"mykey" in {"mykey":123} True

5. min max

6. from random import

7. result = input(" input the num ")   type(result) 是string这点要注意###
```

### list comperhensive

```python
mylist = [x for x in "world"]
equals to
mylist = []
for x in "world":
    mylist.append(x)
    
mylist = [x**2 for x in range(1,10:1)]

mylist = [x*y for x in listx for y in listy]
简洁，但是易读性差
```



等效

## 函数方法

类智能推荐函数，.+tab 参数介绍，tab+shift。 help函数可以输出文档。类似man

```python
def my_fun(param1 ,param2=defaultvaluue):
    '''document and help'''
    print("hello")
    return "a"
```

可变参数

```python
def myfunc(*args):
    sum(args) #参数带星号，是可变参数数量
def myfunc1(**kwargs):
    print(kwargs)
    print(kwargs["key"])
myfunc1( key = "this is key")
```

map 函数

```python
def func():
    pass
list= [1,2,3,4]
for item in map(func,list):
    return item
listresult (map(func,list))
```

对list中所有元素执行一次 func

filter 函数

```python
def is_even(num):
    return num%2==0
mynum=[1,2,3,4,5]
filter(is_even, mynum)#会返回一个函数地址
list(filter(is_even, mynum)) 保留符合条件的函数
```

lamada 表达式：有时一些函数只用一次，因此可以定义一个匿名函数

```python
def square(num):
    return num**2
lamada num: num**2 # lamada params: returnvalue
```



### LEGB rule

L: local

E:enclosure function locals

G:Globals 

B:built in type

LEGB的顺序进行执行。