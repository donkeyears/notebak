

[TOC]

**Security is a journey, not a destination.**

## common attack pattern

CAPEC： common attack pattern Enum and classfication.

记录了CVE 和CWE是一些常见的漏洞。

## how a attack do .

decide by the intention of people.

how they think:everything can be broken;path of least resisteence; thinking out of box; curious demeanor

four type of user: developer, tester, whilt halt,black hat. Their  Goal, approach, intent and rewards is different.

what we develop do:

1. acknowledge that your code will be attacked. 2. design with hacker inmind.expect the unexpected. 3. threat module.

what can tester do: 1. try to break feature. 2. Fuzzy testing by codenomicon

## XSS CSRF

cross site scriping； 跨越浏览器进程去访问额。获得本地权限修改或者影响远程server，进而影响更多人。

reflect xss： 执行输入里的html代码；stored xss； 存在了服务器，影响别人。比如模拟一个link给别人。dom xss；利用文件类型。

避免方法：1. 谨慎输出，转义字符2. 使用安全框架 3. 考虑攻击，4. 白名单输入

CSRF： cross site request forgey

## SQL injection

预防：1. input validation 2. use prepared statement, parameterized query. stored procdure, and bind vari. to 3. least privelege. 4.lerverage different account for write and read.

5. input valid:sanitix input with regex, whitelist input, use library,escape all user input. 6/ don't releay on client validation. 7. Encode before passing. 8 static scan.

## Protcol attack

protocol designer. use threat module from begining. Developer: input validation.

## buffer heap overflow

类似本来杯子不满。攻击者倒水溢出了。导致弄脏了桌子，也掺杂了新的东西。

stack overflow 在程序堆栈注入代码，添加空指令，跳转地址进行攻击

heap overflow： 比stack 难。因为没有明确地址可以跳转。

预防：1. 选语言，2. Safe lib 3. 进程空间保护。4. 数据保护。

## hardware  attack

## deny of service

通过攻击耗尽计算资源，内存，网络cpu，等等。

确保留一些资源做重要事情，先校验后处理，架构设计上的处理。做性能测试找出短板，处理异常。考虑异常。

## Social engineering 

Impersonation 

Dumpster diving

inference

## atack tool

vulnerability tools; nessus ; application vulnerabilty testing;metasploit

Nmap, amap, xprobe



## threat module

reqire 1*  -> design 5* -> code 10* ->dev test 20* -> beta test50*  -> ops 150*



## safec

1. defination constraint handler saves time and assures notification.
2. strcpy_s  立马fix 可以限制长度，然后申请空间多申请一位置零。长远safec
3. memcpy 立马fix，可以取二者长度min。长远sfaec
4. 用safec 不要自己实现。

## input validation

check input everywhere. use whitelist instead of black list; safe library; escape input text

## principle of least privelegee



