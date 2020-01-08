Git Cheetbook



## git revert

1. 如果是直线提交。 Comit1->commit2->commit3.... 没有merge。那么

```bash
git revert commit1 # 将comit1的改动进行一个反提交。解决冲突后即可
```

2. 如果是有merge的提交。比如分支A merge到分支B。一般B为base分支。此时撤销一个merge提交。需要制定父分支。a b merge提交c

```bash
git show c# c为merge的comit 哈希值
Merge: a b# a b 为两个分支的comit
git revert -m 1 # 1选择了保留a所在的分支。2 选择b所在的分支。
```



2. sss