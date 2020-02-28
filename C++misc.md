C++misc



strings.h头文件是从BSD系UNIX系统继承而来。有的函数如bzero是很老的函数了。如果为了用它们则需要inlcude。否则用string.h。正常不应该用这些函数，应该用string.h中的如memset

Strcasecmp posix stricmp windows

## 语法



宏 和枚举enum

Enum p{a,b}k;

a,b 为可选值。p为类型。k为变量。k只能赋值a，b（实际就是1，2）。所以赋其它会报错，此时enum的实际数字大小其实也没用了，毕竟我们只能用a，b赋值。不能用1，2；数字与a，b对应交给编译器去了。容易检查错误。宏则随意赋值。



typeid(*this).name() 获得该类名字。如果再构造函数种只能得到父类名字，在构造之后会得到本身类名。

__FUNCTION__ 可以打印类::函数名。 如果当作参数，static const char __func__[] = "function-name";



Std::map::erase 在c++98 中返回为void 在c++ 11中返回为iterator。这点注意

解决办法，在cmake3.1之上set (CMAKE_CXX_STANDARD 11) 3.1之下add_compile_options(-std=c++11)

 

c++中临时变量不能作为非const的引用参数 



查看预定义宏

linux

touch a.h   # 创建一个空文件

cpp -dM a.h#查看宏

cpp是查看预处理的命令。Cpp(c preprocessor)

 

vs直接看项目属性

 

 

预处理器做四个

1. 文件包含 #include <>系统 ""自定义。
2. 宏替换 #define      #undef
3. 条件编译  #if、#elif、#else、#endif、#ifdef、#ifndef
4. 特殊控制 #error、#pragma

cpp是预处理的程序，详细参数

<https://www.ibm.com/support/knowledgecenter/zh/ssw_aix_71/com.ibm.aix.cmds1/cpp.htm>

 

gcc预处理参数

<https://gcc.gnu.org/onlinedocs/gcc/Preprocessor-Options.html>



任何类型可以赋值给viod* void*赋值给其它则需要转换

句柄是一个标识符，通过句柄系统可以得到指针，但是用户不行，

可以是标识符，也可以是map的key或者指针。

linux下对应的文件描述符。fd



## 头文件循环依赖

A.h

\#include"a.h"

\#include "b.h"

\#include"c.h"

 

 

C.h

\#include"a.h"

此时a还没有处理完，c中就要接着include a这样就是循环include

避免

1. Include guard。比如ifndef 或者pragma once
2. 尽量使用前向声明，不一定非得用include。比如只用了一个类class A的名字，没用内部函数，加一句class A；就可以了。
3. 尽量一个头文件一个cpp文件。
4. include头文件使用绝对路径。
5. Include      原则；本项目，本公司，第三方c++，std标准，第三方c，libc。

## 二进制兼容

二进制兼容：在升级库a时，依赖a的库b不用重新编译。

改变兼容的操作

1. 添加默认参数。
2. 添加虚函数，因为虚函数表会变化。
3. 增加默认模版参数
4. 改变enum的值。也可能导致错乱
5. 添加减少数据成员

例如： O_RDONLY | O_WRONLY != O_RDWR 三个宏分别为0，1 2. 0|1 得不到2. 这不太符合逻辑。然而此处，如果我们改了他，用1 2 3.那么依赖这个库的文件就会冲突。

## weak ptr

Shared_ptr 是一种智能指针。是通过在其中统计使用此指针的对象数来保证指针的安全。

Weak_ptr 类似于shared_ptr 的一个助手。Shared ptr不受影响。该析构就析构。如果lock返回空，那么就是shared ptr已经吸够了

weakptr只是想找这个指针指向的内存，但是不想管理生命周期。

1. Weak_ptr<a> wpa (spa) 不改变spa的引用数。
2. Shared_ptr<a>      spa =wpa.lock() 通过lock函数获取weakptr的sharedptr进行后续使用。
3. wpa。expired（）检查其是否析构了。
4. weakptr没有实现->      等操作。
5. weakptr出现是为了解决 a包含b智能指针。b包含a智能指针。这样a b都不能正常析构了，因为循环引用。

## map

map清空使用for循环，注意iter要在循环体内，删除处++ 

erase（iter++） 因为erase后iter ++ 就是为定义行为。因为map不是顺序存储。

clear和erase分别都能清空。但是如果map第二位是指针，那么clear并不会清空指针对应的内存。



## C++不同系统数据模型

数据模型

数据模型（LP32 ILP32 LP64 LLP64 ILP64 ）

32 64 指位数。I为Int，L为long P为Pointer。

LP32指 Long Pointer是32位，同理LP64指Long Pointer为64位。

绝大多数Unix为LP64  windows为LLP64. 因此win64 下long为32位。

win这样操作导致32位应用可以直接在64位上运行。

TYPE                    LP32    ILP32    LP64    ILP64    LLP64

CHAR                       8          8          8          8          8

SHORT                   16        16        16        16        16

INT                         16         32        32        64        32

LONG                     32        32         64        64        32

LONG LONG          64        64         64        64        64

POINTER                32       32          64        64        64

如果想多平台中立，就是平台一致，那么可以用<inttypes.h>头文件，

它定义了int8_t uint32_t uintptr_t

 

 

<https://stackoverflow.com/questions/384502/what-is-the-bit-size-of-long-on-64-bit-windows>

 

<https://en.m.wikipedia.org/wiki/64-bit_computing#64-bit_data_models>

 

<https://www.zhihu.com/question/54648811>

 

<https://www.cnblogs.com/lsgxeva/p/7614856.html>



## 编译

-fPIC 在生成目标文件的时候使用相对地址，而不是绝对地址，防止将来链接起来，地址冲突。

add_compile_options

C++程序在链接一个静态库时，如果该静态库里的某些方法没有任何地方调用到，最终这些没有被调用到的方法或变量将会被丢弃掉，不会被链接到目标程序中。这样做大大减小生成二进制文件的体积。



## c runtime library

1. C运行时库（C run-time library, CRT）。C程序运行时需要的库函数。C语言发明时，用C重写了90%的系统函数，把其中最常用的独立，形成头文件+LIBRARY。称为C run-time library.

2. 各厂商实现自己编译器和系统的C运行时库。ANSi进行一些标准化。

3. C      run-time library 包含初始化代码和错误处理代码。比如如何初始化环境调用main()

4. Standard C++      library，由于c++是c的超集，所以c run不需要重做。包含：

5. 1. c run-time library
   2. STL
   3. 如vc中添加的LIBCP.LIB,       LIBCPMT.LIB和 MSVCPRT.LIB

6. 由于CRT是在20      70s发明的，那时候多线程还不多，所以后续VC++ 需要添加支持多线程。Visual      C++提两版本的CRT，单线程和多线程。多线程版本提供了

7. 1. 每个线程提供一个errno全局变量
   2. 多线程数据结构同步机制保护

8. Visual      C++ 提供，单线程（ML，MLd），多线程。多线程提供了debug release；静态 动态（MD MT MDd      MTd）

9. MT提供多线程CRT库的静态lib版本，注意，这儿静态指的是运行时库，而不是我们实现的dll。会将运行时库静态链接到二进制中，将库名      LIBCMT.lib 放入 .obj 。运行时，不需Dll，轻微性能提升，体积大，多项目不相关，独自多份内存。

10. MD则采用链接时，不链接进去，而是使用MSVCRxx.DLL的导入库MSVCRT.lib进行链接放入obj中。需要dll，体积小，内存共享。

11. msvcrt* 是 VC 6 及之前的      VC runtime ， c 和 c++ 的函数都在一个文件

msvcr* 是 VC7 到 VS2013 的 ， c 对应 msvcr*.dll ， c++ 对应 msvcp*.dll

VS2015 已经没有msvcr140.dll了,只有msvcp140.dll,  CRT dll已经被拆成了两个: ucrtbase.dll,包含标准c库的内容;vcruntime140.dll,包含vc++所用到的一些基础支持特定内容.

 

ucrtbase.dll vcruntime140.dll msvcp140 MSVC++ 14.0 _MSC_VER == 1900 (Visual Studio 2015) 

msvcr120 MSVC++ 12.0 _MSC_VER == 1800 (Visual Studio 2013) 

msvcr110 MSVC++ 11.0 _MSC_VER == 1700 (Visual Studio 2012) 

msvcr100 MSVC++ 10.0 _MSC_VER == 1600 (Visual Studio 2010) 

msvcr90 MSVC++ 9.0 _MSC_VER == 1500 (Visual Studio 2008) 

msvcr80 MSVC++ 8.0 _MSC_VER == 1400 (Visual Studio 2005) 

msvcr71 MSVC++ 7.1 _MSC_VER == 1310 (Visual Studio 2003) 

msvcr70 MSVC++ 7.0 _MSC_VER == 1300 

 

<https://blog.csdn.net/wqvbjhc/article/details/6612099>



## 代理

代理

1. web普通代理

2. 1. 正向代理。代理替客户端去访问网站。隐藏客户端。
   2. 反向代理。代理替服务器处理各地请求。隐藏服务器。

3. 隧道代理

4. 1. HTTP       客户端通过 CONNECT 方法请求隧道代理创建一条到达任意目的服务器和端口的 TCP 连接，并对客户端和服务器之间的后继数据进行盲转发。

<https://imququ.com/post/web-proxy.html>

## dll调用 

Dll 调用

1. 显式调用：

2. 1. 必备：头文件，dll文件
   2. 过程：include头文件和windows.h ; LoadLibrary()加载dll到内存，GetProcAddress()获取函数地址，FreeLibrary()释放内存。

3. 隐式调用：

4. 1. 必备：.h .dll .lib
   2. 过程：include头文件；vs工程属性-输入-附加依赖项-**.lib或者 #pragma comment(lib,"testDLL.lib")

5. dll导出导入函数。

6. 1. 导出： __declspec(dllexport)或者定义def文件。
   2. 导入：__declspec(dllimport)或者不加也可以用，但是唯独前者可以导入变量。
   3. **.def       文件定义函数。

DLLMAIN函数。

BOOL WINAPI DllMain(

  _In_ HINSTANCE hinstDLL, // 指向自身的句柄

  _In_ DWORD fdwReason, // 调用原因

  _In_ LPVOID lpvReserved // 隐式加载和显式加载

);

类似于每个exe都又一个main函数入口一样。dll也有一个dllmain入口。进程load之后第一个执行的函数。

dll被调用的时候，会被load进进程地址空间。同一个dll只在第一次load时调用DLLMAIN. 如果新建线程则会重新调用。

dll被静态或者动态（LoadLibrary FreeLibrary）加载/释放 会调用DLLMAIN。

fdwReason 有四种DLL_PROCESS_ATTACH、DLL_PROCESS_DETACH、DLL_THREAD_ATTACH和DLL_THREAD_DETACH。分别代表进程进入，离开，线程进入离开。



## stl wtl atl

1. STL 即      Standard Template Library 

STL（标准模板库)是惠普实验室开发的一系列软件的统称。它是由Alexander Stepanov、Meng Lee和David R Musser在惠普实验室工作时所开发出来的。现在虽说它主要出现在C++中，但在被引入C++之前该技术就已经存在了很长的一段时间。 

 

STL的代码从广义上讲分为三类：algorithm（算法）、container（容器）和iterator（迭代器），几乎所有的代码都采用了模板类和模版函数的方式，这相比于传统的由函数和类组成的库来说提供了更好的代码重用机会。在C++标准中，STL被组织为下面的13个头文件：<algorithm>、<deque>、<functional>、<iterator>、<vector>、<list>、<map>、<memory>、<numeric>、<queue>、<set>、<stack>和<utility>。以下笔者就简单介绍一下STL各个部分的主要特点。 

1. ATL是一个产生C++/COM代码的框架，就如同C语言是一个产生汇编代码的框架 
2. WTL全称为Windows      Template Library，构架于ATL之上，采用C++模板技术来包装大部窗口控制，并给出一个与MFC相似的应用框架。 

## 工具ag

Ag [file type] [option] pattern [file path]

 

1. 输出选项

2. - -A -B       -C。n： 匹配行之后，之前，前后 n行
   - -g       搜索符合的文件名。搜索文件。
   - -l       只打印匹配的文件名，不打印具体内容 -L 不匹配的文件名。

3. 搜索选项

4. - -i忽略大小写
   - -depth=1 只搜索当前目录

5. 选项

## valgrind

1. Invalid read 就是读取不该读区的指针。说明指针没有正确析构

1. definitely lost: 没有释放new出来的指针。可以看new之后所有释放的地方。也可以根据pid去看log

## cmake

Cmake <https://www.ibm.com/developerworks/cn/linux/l-cn-cmake/index.html>

介绍了基本cmake，添加子目录，添加外部库。



cmake读取环境变量 $ENV{JAVA_HOME}

设置 set( ENV{PATH} /home/martink )

if(NOT DEFINED ENV{JAVA_HOME}) # 没有找到JAVA_HOME环境变量 message(FATAL_ERROR "not defined environment variable:JAVA_HOME") endif()

 

Cmake 添加预定义宏。

Cmake -H -DDEFINE_MACRO=1

1. IF(DEFINE_MACRO)

1. ADD_DEFINITIONS(-DMACRO)

1. ENDIF(DEFINE_MACRO)



Cmake 生成动态库的时候，在子目录下不要用static。cmake不支持从静态库直接链接到动态库。所以在子目录生成OBJECT 。这个类型

<https://stackoverflow.com/questions/11429055/cmake-how-create-a-single-shared-library-from-all-static-libraries-of-subprojec>



cmake选项

cmake -H. -Bbuild -G "MSYS Makefiles"

-H 指定root目录，

-B指定build输出临时目录。

Cmake 3.13之上会有一个选项-S达到一样目的。上述俩命令是undocument的。

Cmakecache.txt是一种缓存，将一些set，option的变量存放。有时build目录更改实现失败就是这个缓存没清

输出目录结构，这个-H -B就是指定了其输出的目录，后续add_subdirectory 都是相对于这个指定的目录。

 

如需要make过程详细链接参数，就是显示g++ -D。。。 .cpp .o可以用

1. CMakeLists.txt 中SET( CMAKE_VERBOSE_MAKEFILE on )
2. Make make VERBOSE=1

如需要打印一些信息，可以用message语法。message(${PROJECT_SOURCE_DIR})

 

更改输出到指定目录

1. add_subdirectory(src bin) 将src目录的源文件输出到bin，但是临时文件也会有
2. set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib) 设定输出目录

 

 

参考 <https://blog.csdn.net/dbzhang800/article/details/6314073#comments>

<https://blog.csdn.net/dbzhang800/article/details/6329314>

此文写作方式很适合初学者。先按照例子从简单到复杂，再去写参数，语法，总结好表格。

命令手册类https://www.jianshu.com/p/175597814bc7



## 协议

Ssrc 与流相关，制定了不同的分辨率。

csi是标示设备的

一个scr（sub session channel request ）一个ssrc

## RTP RTCP

RTP发偶数端口，RTCP发+1 奇数端口

RTP全名是Real-time Transport Protocol 实时传输协议,为实时传输提供时间信息和流同步

RTCP Real-time Transport Control Protocol，即实时传输控制协议，qos

对于流信号。降低延迟，恢复时序。

在发送端，为降低延迟，往往对传输数据进行预处理（降低质量和高效压缩）。在接收端为了恢复时序，采用了接收缓冲；而为了实现媒体的流畅播放，则采用了播放缓冲。

版本号（V）：2比特，用来标志使用的RTP版本。

 

填充位（P）：1比特，如果该位置位，则该RTP包的尾部就包含附加的填充字节。

 

扩展位（X）：1比特，如果该位置位的话，RTP固定头部后面就跟有一个扩展头部。

 

CSRC计数器（CC）：4比特，含有固定头部后面跟着的CSRC的数目。

 

标记位（M）：1比特,该位的解释由配置文档（Profile）来承担.

 

载荷类型（PT）：7比特，标识了RTP载荷的类型。

 

序列号（SN）：16比特，发送方在每发送完一个RTP包后就将该域的值增加1，接收方可以由该域检测包的丢失及恢复包序列。序列号的初始值是随机的。

 

时间戳：32比特，记录了该包中数据的第一个字节的采样时刻。在一次会话开始时，时间戳初始化成一个初始值。即使在没有信号发送时，时间戳的数值也要随时间而不断地增加（时间在流逝嘛）。时间戳是去除抖动和实现同步不可缺少的。

 

同步源标识符(SSRC)：32比特，同步源就是指RTP包流的来源。在同一个RTP会话中不能有两个相同的SSRC值。该标识符是随机选取的 RFC1889推荐了MD5随机算法。

 

贡献源列表（CSRC List）：0～15项，每项32比特，用来标志对一个RTP混合器产生的新包有贡献的所有RTP包的源。由混合器将这些有贡献的SSRC标识符插入表中。SSRC标识符都被列出来，以便接收端能正确指出交谈双方的身份。

 ———————————————— 

版权声明：本文为CSDN博主「彭令鹏」的原创文章，遵循CC 4.0 by-sa版权协议，转载请附上原文出处链接及本声明。

原文链接：https://blog.csdn.net/bripengandre/article/details/2238818

 

RTCP的主要功能是：服务质量的监视与反馈、媒体间的同步，以及多播组中成员的标识。在RTP会话期 间，各参与者周期性地传送RTCP包。RTCP包中含有已发送的数据包的数量、丢失的数据包的数量等统计资料，因此，各参与者可以利用这些信息动态地改变传输速率，甚至改变有效载荷类型。RTP和RTCP配合使用，它们能以有效的反馈和最小的开销使传输效率最佳化，因而特别适合传送网上的实时数据

填充（P）：同RTP包头域。

 

接收报告计数器（RC）：5比特，该SR包中的接收报告块的数目，可以为零。

 

包类型（PT）：8比特，SR包是200。

 

长度域（Length）：16比特，其中存放的是该SR包以32比特为单位的总长度减一。

 

同步源（SSRC）：SR包发送者的同步源标识符。与对应RTP包中的SSRC一样。

 

NTP Timestamp（Network time protocol）SR包发送时的绝对时间值。NTP的作用是同步不同的RTP媒体流。

 

RTP Timestamp：与NTP时间戳对应，与RTP数据包中的RTP时间戳具有相同的单位和随机初始值。

 

Sender’s packet count：从开始发送包到产生这个SR包这段时间里，发送者发送的RTP数据包的总数. SSRC改变时，这个域清零。

 

Sender`s octet count：从开始发送包到产生这个SR包这段时间里，发送者发送的净荷数据的总字节数（不包括头部和填充）。发送者改变其SSRC时，这个域要清零。

 

同步源n的SSRC标识符：该报告块中包含的是从该源接收到的包的统计信息。

 

丢失率（Fraction Lost）：表明从上一个SR或RR包发出以来从同步源n(SSRC_n)来的RTP数据包的丢失率。

 

累计的包丢失数目：从开始接收到SSRC_n的包到发送SR,从SSRC_n传过来的RTP数据包的丢失总数。

 

收到的扩展最大序列号：从SSRC_n收到的RTP数据包中最大的序列号，

 

接收抖动（Interarrival jitter）：RTP数据包接受时间的统计方差估计

 

上次SR时间戳（Last SR,LSR）：取最近从SSRC_n收到的SR包中的NTP时间戳的中间32比特。如果目前还没收到SR包，则该域清零。

 

上次SR以来的延时（Delay since last SR,DLSR）：上次从SSRC_n收到SR包到发送本报告的延时。

## SDP

SDP 完全是一种会话描述格式（对应的[RFC2327](https://www.rfc-editor.org/rfc/rfc2327.txt)） ― 它不属于传输协议。但使用传输协议如会话通知协议（SAP）、会话初始协议（SIP）、实时流协议（RTSP）、MIME 扩展协议的电子邮件以及超文本传输协议（HTTP）。

SDP 不支持会话内容或媒体编码的协商，所以在流媒体中只用来描述媒体信息。协商由RTSP来实现

 

 

SDP协议格式

＜type＞ = < value > [CRLF]

type: 该字节为单字节（如： v，o, m等）区分大小写，=号俩侧部允许有空格

value: 为结构化文本串

Session description
​     v=  (protocol version number, currently only 0)
​     o=  (originator and session identifier : username, id, version number, network address)
​     s=  (session name : mandatory with at least one UTF-8-encoded character)
​     i=* (session title or short information)
​     u=* (URI of description)
​     e=* (zero or more email address with optional name of contacts)
​     p=* (zero or more phone number with optional name of contacts)
​     c=* (connection information—not required if included in all media)
​     b=* (zero or more bandwidth information lines)
​     One or more Time descriptions ("t=" and "r=" lines; see below)
​     z=* (time zone adjustments)
​     k=* (encryption key)
​     a=* (zero or more session attribute lines)
​     Zero or more Media descriptions (each one starting by an "m=" line; see below)

Time description (mandatory)
​     t=  (time the session is active)
​     r=* (zero or more repeat times)

Media description (if present)
​     m=  (media name and transport address)
​     i=* (media title or information field)
​     c=* (connection information — optional if included at session level)
​     b=* (zero or more bandwidth information lines)
​     k=* (encryption key)
​     a=* (zero or more media attribute lines — overriding the Session attribute lines)

 

[sdp wikipedia](https://en.wikipedia.org/wiki/Session_Description_Protocol)

 

八、简单的RTSP消息交互过程

C表示RTSP客户端,S表示RTSP服务端

\1.   第一步：查询服务器端可用方法

 1.C->S:OPTIONrequest       //询问S有哪些方法可用

1.S->C:OPTIONresponse    //S回应信息的public头字段中包括提供的所有可用方法

\2.   第二步：得到媒体描述信息

2.C->S:DESCRIBE request      //要求得到S提供的媒体描述信息

2.S->C:DESCRIBE response    //S回应媒体描述信息，一般是sdp信息

\3.   第三步：建立RTSP会话

3.C->S:SETUPrequest            //通过Transport头字段列出可接受的传输选项，请求S建立会话

3.S->C:SETUPresponse          //S建立会话，通过Transport头字段返回选择的具体转输选项，并返回建立的Session ID;

\4.   第四步：请求开始传送数据

4.C->S:PLAY request        //C请求S开始发送数据

4.S->C:PLAYresponse            //S回应该请求的信息

\5.   第五步： 数据传送播放中

S->C:发送流媒体数据    // 通过RTP协议传送数据

\6.   第六步：关闭会话，退出

6.C->S:TEARDOWN request      //C请求关闭会话

6.S->C:TEARDOWN response //S回应该请求

上述的过程只是标准的、友好的rtsp流程，但实际的需求中并不一定按此过程。

其中第三和第四步是必需的！第一步，只要服务器客户端约定好，有哪些方法可用，则option请求可以不要。第二步，如果我们有其他途径得到媒体初始化描述信息（比如http请求等等），则我们也不需要通过rtsp中的describe请求来完成。

[雷霄骅 媒体介绍。很通俗易懂](https://blog.csdn.net/leixiaohua1020/article/details/11955341)

## sip

基本名词

transaction事务：一个sip请求和触发的应答。

dialog对话：端到端sip关系，由callid，from tag， to tag确定。在200ok回来后才凑齐。信令层，

session会话：媒体交换之后建立。交换sdp了就算。可以用invite-200交换sdp也可以通过200-ack交换。媒体层。

请求指令

1. Register： UA（user agent）向SIP register登记当前ua的ip地址。

2. Invite：邀请用户加入会话，body中可以带会话描述符（可为SDP）请求的过程也可以协商端口编码等。当会话建立中，需要修改参数，仅需一方发送re-Invite即可。

3. ACK：确认Invite。也可以Invite不带sdp而在ACK里放sdp.

4. Cancel：取消一个已经接收，但没有接受的请求。比如在还没有发送ACK的时候。类似电话没接我就挂了。

5. 1. A.invite b超时未返回；A.cancel. B.200ok ; B.487 a.ack487 cancel算一个。478 ack算invite的返回。

6. Bye: 结束一个会话。双方皆可挂电话。

7. Option：询问服务器功能支持。

握手

Invite 使用三次握手，Ack作为最后一个请求。Cancel，bye，option，register均二次握手，即简单请求响应。

Invite 请求



其中180ring 和100 trying不算进来，因为这些在多个中专的情况下不保证回传，sip对这种临时状态并不非常关注。所以不算近三握手。

重传

sip可基于UDP也可以TCP。如果UDP则有可能需要重传。从UAC->proxy1->proxy2->UAS 中间可以tcp udp缓和。每个收到都会回传一个100trying。如果没有收到。则需要重传。

Sip消息结构

类似于HTTP，纯文本。

INVITE sip:bob@biloxi.com SIP/2.0
​       Via: SIP/2.0/UDP pc33.atlanta.com;branch=z9hG4bK776asdhds
​       Max-Forwards: 70
​       To: Bob <sip:bob@biloxi.com>
​       From: Alice <sip:alice@atlanta.com>;tag=1928301774
​       Call-ID: a84b4c76e66710@pc33.atlanta.com
​       CSeq: 314159 INVITE
​       Contact: <sip:alice@pc33.atlanta.com>
​       Content-Type: application/sdp
​       Content-Length: 142

(Alice’s SDP not shown)

 

1. Start line 分为请求行和状态行

2. 1. INVITE sip:bob@zte.com SIP/2.0
   2. SIP/2.0 200 OK

3. Header

4. 1. CALL-ID： 一个邀请及后续事务，对应一个会话。
   2. CSeq：会话中事务排序。Invite之后每个事务递增。cancel和ack保持原来，因为他是对上一个事务的处理。
   3. Contact：被叫返回200ok带上了自己的信息。这样会话后续直接根据ip走就可以了。
   4. Recode-Route：中间服务器添加。用于下次再走一样的路，根据这个放在route       set字段规定下次必须走这条路。
   5. To：区别于请求行的Request-URI。To为最后目的地地址。而Request-URI一般是下一跳的地址。
   6. Via：       所有处理请求的代理地址。每一条增加，回溯用。也可以检测路由环。里头的branch用于事务层，也就是一次请求及后续响应。

5. Body

常见应答

类型 状态码 状态说明

临时应答(1XX) 100 Trying 正在处理中

180 Ringing 振铃

181 call being forwarder 呼叫正在前向

182 queue 排队

181* session progress 会话进行

会话成功(2XX) 200 OK 会话成功

重定向(3XX) 300 multiple 多重选择

301 moved permanently 永久移动

302 moved temporaily 临时移动

305 use proxy 用户代理

380 alternative service 替代服务

[常见应答](https://www.cnblogs.com/please/archive/2011/03/07/1974804.html)

invite事务



[sip六个命令](http://blog.sina.com.cn/s/blog_4bcba87f01016ror.html)

[消息体结构](https://www.cnblogs.com/cy568searchx/p/4369253.html)

[dialog session transaction 区别。图示很棒](https://blog.csdn.net/wind19/article/details/7423248)







