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

## git 多个远程仓库

有时候，可能多个git仓库基于同一个基础。但是往不同的地方push。比如repo a b都要push。这时候我们就要添加多个remote。

remote代表了远程的repo。默认来下来的代码为origin。所以我们命令都是

```bash
git pull origin master:tmp
```

实际我们可以添加多个remote。

```bash
git remote add remoteName url # 这儿添加了新的repo。但还要pull才能更新repo分支。
```

但是假设我在repo A修改。repo B还没有拉代码。此时我直接git pull originb branch1. 这时候来回来的代码会和repoA的当前分支自动进行merge。这样就会有很多冲突。解决办法，用fetch

```bash
git fetch remoteName remotebranchA:localbranchA  # 远程拉过来新建分支，但不合本分支合并。
```

