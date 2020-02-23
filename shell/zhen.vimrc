" edit plugin "
call plug#begin('~/.vim/plugged')
Plug 'skywind3000/vim-keysound' "depend on python-sdl2  "
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'luochen1990/rainbow'
Plug 'ludovicchabant/vim-gutentags'  " tags file auto generate."								
call plug#end()
"  go into vim. :PlugInstall  config plugin in .vimrc."


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



"   this is how a comment looks like in ~/.vimrc  one quotation is enough.