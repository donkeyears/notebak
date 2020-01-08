# linux下时间函数

## 时间结构

linux下有四种时间结构类型：time_t , struct tm, struct timeval, struct timespec

### time_t

time.h 头文件中 typedef long time_t

实际为一个32位数，取从1970.1.1至今**秒**数，到2038年会溢出。

| 结构体          | 精确度 | 实现                                      | 获得函数        | 简介               |      |
| --------------- | ------ | ----------------------------------------- | --------------- | ------------------ | ---- |
| time_t          | s      | typedef long time_t                       | time()          | 从1970.1.1至今秒数 |      |
| struct tm       | s      | tm_sec, tm_min, tm_hour....               |                 |                    |      |
| struct timeval  | us     | time_t tv_sec;秒 suseconds_t tv_usec;微秒 | gettimeofday( ) | 获得秒与微秒数     |      |
| struct timespec | ns     | time_t tv_sec; long tv_nsec;              |                 | 秒与纳秒           |      |

ctime() 将time_t转换为当地时间字符串。

time_t 精确到秒 timeval精确到微妙，



## 常用时间函数

| 函数名       | 头文件       | 函数定义                                                   | 描述                                                      |
| ------------ | ------------ | ---------------------------------------------------------- | --------------------------------------------------------- |
| time()       | time.h       | time_t time(time_t* timer)                                 | 1970.1.1至今秒数，若timer非空，也会存放在里头。失败返回-1 |
| ctime()      | time.h       | char* ctime(const time_t* time)                            | time_t -> char*。注意传的指针。                           |
| gmtime()     | time.h       | struct tm* gmtime(const time_t * t)                        | time_t -> GMT struct tm 时间                              |
| localtime    | time.h       | struct tm* localtime(const time_t * t)                     | time_t -> tm结构的本地时间                                |
| mktime       | time.h       | time_t mktime(struct tm *p_tm)                             | tm -> time_t                                              |
| asctime      | time.h       | char *asctime(const struct tm *p_tm)                       | tm-> char*                                                |
| difftime     | time.h       | double difftime(time_t t1, time_t t2)                      | T2-t1  in seconds                                         |
| gettimeofday | <sys/time.h> | int gettimeofday(struct timeval *tv, struct timezone *tz); | 获取时间，s us放入tv，时区放入 tz                         |

### 时间格式化

```c
size_t strftime(char *str, size_t maxsize, const char *format, const struct tm *timeptr)
```

格式化时间。放入str中。最长maxsize。 timeptr为 tm结构体。可以用gmtime转换

ISO 8601: yyyy-MM-dd'T'HH:mm:ss'Z'格式：%FT%TZ