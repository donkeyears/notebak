# C++字符串与字符数组

## 4种字符串

1. string:类，可动态拓展。可+
2. char*：指向字符串的指针（首字母）
3. const char* ：不能通过指针对**字符串**修改。char* const 指针不能改。
4. char[]：字符数组。

```
char* a="string1";// a char型指针，可修改a。	a指向内存有时可写有时不行。看等号右边
char b[]="string2";//b 数组名字，不可修改b的值。b指向内存可读写。
//“string1”是内存中一块固定常量，不可修改。a目前指向常量故不可以修改。如果a=b，然后a指向的内存就可以修改了
// a可以指向字符串常量如“string”，也可以指向字符串变量如b。指向类型决定可否写。
```

char* a a指向常量区的字符串“string”

char[] b 栈区分配一个字符数组。

char* a=“string” 不严谨，因为容易给a赋值，此时会崩溃。所以推荐用const char* a

***作为形参，a，b均为字符串指针。***

const char* 指向不能改。char[]  char* const 指针不能改。

const char* 变成char* 很难。需要cast

## string ，char* ，const char* ，char[] 转换

### 转换表格

| 目标⬇️源头➡️           | string a="hi"                            | char* b="hi" | const char* c="hi"   | char d []="hi" |
| -------------------- | ---------------------------------------- | ------------ | -------------------- | -------------- |
| string a             | NULL                                     | a=b          | a=c                  | a=b            |
| Char* b              | c=a.c_str  b=b=const_cast<char*>c        | NULL         | b=const_cast<char*>c | b=d            |
| const char* c        | c=a.c_str()  c=a.data() a.copy(c,size,0) | c=b          | NULL                 | c=d            |
| char d []  const指针 | strcpy()                                 | strcpy       | strcpy               | NULL           |

1. 成为string。直接赋值
2. 成为const char* 直接赋值（除了string）
3. 成为char d[] strncpy      因为这是一个指针常量，指针不能赋值。指针内容可以copy
4. char[] 成为其它，直接赋值。
5. 成为char* 需要转为constchar* 再强转。 char*p=（char *）str.c_str().
6. Str.c_str 带\0     str.data() 不带

```c++
//一定要使用strcpy()函数等来操作方法c_str()返回的指针 
//比如：最好不要这样: 
char* c; 
string s="1234"; 
c = s.c_str(); //c最后指向的内容是垃圾，**因为s对象被析构**，其内容被处理
 
//应该这样用： 
char c[20]; 
string s="1234"; 
strcpy(c,s.c_str()); 
//这样才不会出错，c_str()返回的是一个临时指针，不能对其进行操作

```

参考

>[表格比较好](<https://blog.csdn.net/ksws0292756/article/details/79432329>)
>
>[例子比较好](<https://blog.csdn.net/hebbely/article/details/79577880>)