# 锁

加锁后线程也会切换。但是临界区资源被保护。

一个实例：锁加的范围比较大。锁了一个while 循环。while循环不结束，锁不释放。此时可以只锁io操作。while循环让他们去操作。把改的值临时拷贝出来一份。

### 加锁原则

1. 共享资源要加锁。：全局，静态变量。共享内存，文件等。
2. 职责单一。只锁一个资源。
3. 范围小。如果锁了函数调用，可能会使多线程效率低下。
4. 避免嵌套加锁。如果必须则解锁顺序。lock1，lock2 必须unlock2.。再unlock1

### 死锁的四个必要条件

1. 互斥条件。资源只能被一个进程使用。
2. 占有且等待，占有资源且等待资源
3. 不可强行占有。资源使用完前不可剥夺。
4. 循环等待。

几种常见的锁

1. 互斥锁；抢不到就不干了。让别人去用。

   ```cpp
   while (抢锁(lock) == 没抢到) {
       休息，切换线程，等待唤醒
   }
   ```

2. 自旋锁：没加上锁就不断重试。会浪费cpu

   ```cpp
   while (抢锁(lock) == 没抢到) {
   }
   ```

3. 条件锁：抢不到就不做了。有个条件触发回来。

   ```cpp
   while (empty) {
       解锁，等待通知。通知到了执行。
   }
   触发通知(用来收发通知的东西);
   ```

4. 读写锁。可以多个读。但写了就什么都不能做。





> [四种锁介绍](<https://www.zhihu.com/question/66733477>)
>
>