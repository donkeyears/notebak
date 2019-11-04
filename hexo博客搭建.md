#搭建hexo博客

## 1. 安装Node.js

### nvm 安装

nvm负责管理不同版本的Node.js， npm负责管理nodejs的第三方库文件。

Node.js 很大，有版本不同。这时候nvm就是一个管理不同版本的东西。nvm可以管理本地的nvm。nvm会安装在本地home目录。

> curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
>
> Or
>
> wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

### node安装

> nvm install node

## 2. 安装hexo

hexo是node里的一个模块。使用它来搭建博客。

> npm install -g hexo-cli  # -g为安装全局模块。默认只安装到当前目录。只有当前目录可用。

### npm install 简介

npm install 没有参数会根据当前目录下的package.json install。 

npm install pack 安装某个包

npm install -g package。全局安装某个包。

## 3. 本地用hexo搭建博客

>



## 4. github管理方案。

github上分两个分支，一个master，一个hexo。 hexo分支负责保存各种改动命令。而master分支负责存放生成的网页。在_post目录再新建一个repo。这个repo里放笔记。笔记repo可以作为私有repo。而hubio则为共有的。可以访问的。

### 第一次生成网页

主要是安装hexo(其实安装hexo-cli也是一样)，hexo-deploy-git，package.json中的包。

关键这次有hexo init。init后才安装需要的第三方包。会初始化本地的一些包。

> npm install hexo 			# install hexo
>
> hexo init 				# init the folder for hexo. generate package.json
>
> npm install 				# update npm by package.json.
>
> npm install hexo-deployer-git # git plugin for deploy

### clone全新代码后重新生成

重新安装hexo hexo-deploy-git。 第三方依赖包。

> npm install hexo
>
> npm install 
>
> npm install hexo-deployer-git



### 日常更新操作

1. 在hexo分支进行更新markdown文档。
2. 使用hexo-deployer-git 将hexo分支生成网页并deploy到远程master分支。hexo为源文件，master为静态网页。hexo分支本地编辑。master分支由git插件更新。
3. github io会自动同步master分支。

### 本地调试检查

> hexo generate # 根据本地markdown生成静态网页。
>
> hexo server # 本地http://localhost:4000 网页生成调试。



### 设置git账户。

> git config user.name ""
>
> git config user.email ""



## 4. 一些常见问题

### 自动添加标题 hexo-enhancer。

hexo需要使用"hexo new "title name"来生成文章的名字。如果批量转入markdown会导致显示“notitle”，此时可以使用hexo-enhancer这个插件自动生成文件post name。安装后，新生成的文件在deploy的时候就会自动添加文件名了。文件名自动转化为标题title。还可以自动生成cataogly等。

## 参考

[官方首页](<https://hexo.io/zh-cn/docs/setup>)

[使用hexo，换电脑后怎么更新博客](<https://www.zhihu.com/question/21193762>)

