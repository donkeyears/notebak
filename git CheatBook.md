Git Cheetbook

[TOC]



## git revert

1. 如果是直线提交。 Comit1->commit2->commit3.... 没有merge。那么

```bash
git revert commit1 # 将comit1的改动进行一个反提交。解决冲突后即可
```

2. 如果是有merge的提交。比如分支A merge到分支B。一般B为base分支。此时撤销一个merge提交。需要制定父分支。a b merge提交c

```bash
git show c# c为merge的comit 哈希值
Merge: a b# a b 为两个分支的comit
git revert -m 1 c# 1选择了保留a所在的分支。2 选择b所在的分支。
```

revert 已经revert的提交。

如果分支a merge了分支b的内容。然后又revert了merge 提交。此时再去merge b分支不会做任何操作。因为之前已经merge了。这时候要做的就是revert 刚刚revert的提交。

## git 恢复删除分支

有时不小心删除某个本地分支，而且没有push远程，此时可以本地尽快恢复。



1. git log -g 找回之前提交的commit 这个可以找到被删除的提交的commit id。
2. 根据这个commit新建一个分支，git branch newbranch commit-id

这样 根据新创建的分支就把删掉的提交恢复了。

原理。git实际每次提交都保存了。如果我们找到这个提交再补上就可以了。git log -g 也可以用git reflog 替代。



## git amend 修改提交

$ git commit --amend -m 'xxxxxxx'

## git rebase 合并提交

```bash
$ git rebase -i commitid # 是合并commitid之后的所有提交。
弹出窗口中。 把pick字段改为s 
:wq #保存 p s
:wq # 保存commit 信息。

```

