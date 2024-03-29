#C++ 虚函数表

C++通过虚函数实现多态，用父类指针指向子类对象。通过父类指针访问子类函数。这让父类拥有多种形态，简称多态。



### 虚函数表

vtable。是一个保存虚函数的地址的表。一般放在类的最前方以提高性能。一般把类的地址中存的地址就是vtable的起始位置。一般最后一个会放一个结束符以表示虚地址表结束了。

## 覆盖详情

### 一般继承，无覆盖

base f() g() h(). Devoured:public base f1() g1() h1()

1. 虚函数按生命顺序放
2. 父类虚函数在子类之前。
3. 只有一个虚函数表

### 一般继承，有覆盖

derive有一个函数f和base f相同

1. 覆盖的f覆盖原本父类base中f的位置
2. 没有覆盖的依旧按顺序保存

### 多重继承，无覆盖

1. 每个父类都有虚函数表。地址依次放在类的前几个地址。
2. 子类成员放到第一个父类中

### 多重继承，有覆盖

1. 子类会覆盖每一个父类的同名函数。
2. 其他的不变。

## 利用虚函数表

可以根据地址改变访问子类自有的虚函数，访问private函数。



## c++对象内存布局

类结构影响因素：成员变量，虚函数，单一继承，多重继承，重复继承，虚拟继承

### 1）**单一的一般继承**（带成员变量、虚函数、虚函数覆盖）

1. 虚函数表在最前
2. 成员变量按声明和继承顺序依次排放
3. 覆盖在虚函数表中覆盖

### 2）**单一的虚拟继承**（带成员变量、虚函数、虚函数覆盖）

### 3）**多重继承**（带成员变量、虚函数、虚函数覆盖）

1. 每个父类都有虚表
2. 子类成员函数在第一父类
3. 父类按声明顺序排布
4. 成员变量则在每个父类虚函数表后存放。vtb1，int base1， vtb2 int base2

### 4）**重复多重继承**（带成员变量、虚函数、虚函数覆盖）

A->B1

A->B2

B1 b2-> D

则d继承了两次A。A在b1b2中分别发生了覆盖。然后b1 b2按顺序排布，再d覆盖。

### 5）**钻石型的虚拟多重继承**（带成员变量、虚函数、虚函数覆盖

对于共同父类A进行虚继承。那么A的内存分布放在了B1 B2 D之后。

主要优势，省时间省空间。但很少用。

> [陈皓—c++内存布局](<https://coolshell.cn/articles/12176.html>)
>
> [陈皓---C++ 虚函数表](<https://coolshell.cn/articles/12165.html>)