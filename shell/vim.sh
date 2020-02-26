#!/bin/bash


sudo apt install silversearcher-ag curl -y


#fzf offical site https://github.com/junegunn/fzf. vim intorduction  https://segmentfault.com/a/1190000011328080. usage https://vimjc.com/vim-fzf-plugin.html
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


#gtags manual install. need install for use global. or can use homebrew and apt 
wget http://tamacom.com/global/global-6.6.4.tar.gz
tar xzvf global-6.6.2.tar.gz
cd global-6.6.2
./configure
make && make install


cp /path/to/gtags/gtags.vim   ~/.vim/plugin #plugin dir will load automatically.


cd /your/wording/dir  &&    gtags   # generate index file. will generate GPATH  GRTAGS  GTAGS.  you can only search on this dir. 

global your_fun #search on cmd
:Gtags your_fun # search on vim.





#vim install
apt remove --purge vim vim-runtime vim-tiny vim-common vim-doc vim-scripts -y
git clone https://github.com/vim/vim.git
apt install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git -y
./configure --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp=yes \
    --enable-python3interp=yes \
    --with-python3-config-dir=/usr/bin/python3-config\
    --enable-perlinterp=yes \
    --enable-luainterp=yes \
    --enable-gui=gtk2 \
    --enable-cscope \
    --enable-fail-if-missing\
    --prefix=/usr/local
cd vim/src
make clean && make -j
make install
#vim folder introduction.https://www.cnblogs.com/chris-cp/p/4581593.html



# Mac os 
brew install vim  fzf sdl2 global 
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip install pysdl2-dll # need by vim-keysound.  brew install sdl2


~/.vim/autoload load when you need.  ~/.vim/plugin load eachtime vim start.
# install vim-plug, a useful plugin manager.  article about vim-plug  https://linux.cn/article-9751-1.html
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim



# .vimrc

" edit plugin "
call plug#begin('~/.vim/plugged')
Plug 'vim/killersheep'
Plug 'skywind3000/vim-keysound' "depend on python-sdl2  "
Plug 'skywind3000/asyncrun.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'luochen1990/rainbow'
Plug 'ludovicchabant/vim-gutentags'  " tags file auto generate."								
call plug#end()
"  go into vim. :PlugInstall  config plugin in .vimrc."



" asyncrun config "
" 自动打开 quickfix window ，高度为 6"
let g:asyncrun_open = 6
" 任务结束时候响铃提醒"
let g:asyncrun_bell = 1
" 设置 F10 打开/关闭 Quickfix 窗口"
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <c-p> : Files<cr>
nnoremap <c-;> : Gtags 
nnoremap <c-r> : Gtags -r


" config vim-keysound"
let g:keysound_enable = 1
let g:keysound_theme = 'default'
"  config rainbow"
let g:rainbow_active = 1


" config vim-gutentags"
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" use gtags. also can use ctags and cscope"
let g:gutentags_modules = [ 'gtags_cscope']
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录"
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数"
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建"
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif



" reference https://www.ruanyifeng.com/blog/2018/09/vimrc.html. "
set showmode
set showcmd
set encoding=utf-8

filetype indent on
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set backspace   =indent,eol,start

set number
set relativenumber
set cursorline
set textwidth=80
set wrap
syntax on

set showmatch
set hlsearch
set incsearch
set smartcase

set spell spelllang=en_us










"   this is how a comment looks like in ~/.vimrc  one quotation is enough.