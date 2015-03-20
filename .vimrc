"==========================================
" 		Author:MSummer
"       General Settings 基础设置
"       FileEncode Settings 文件编码设置
"       HotKey Settings  自定义快捷键
"       FileType Settings  针对文件类型的设置
"
"==========================================

"==========================================
"基本设置
"==========================================
"定义快捷键的前缀，即<Leader>,这个所有的快捷键都要用"
let mapleader=";"
"开启文件类型侦测
filetype on
"根据侦测到的不同类型加载对应的插件
filetype plugin on
"根据侦测到的不同类型采用不同的缩进格式
filetype indent on
"取消补全内容以分割子窗口形式出现，只显示补全列表
set completeopt=longest,menu

""设置tablist插件只显示当前编辑文件的tag内容，而非当前所有打开文件的tag内容
let Tlist_Show_One_File=1
"设置显示标签列表子窗口的快捷键。速记：taglist"
nnoremap<Leader>tl :TlistToggle<CR>


"设置标签子窗口的宽度
let Tlist_WinWidth=20
"标签列表窗口显示或隐藏不影响整个gvim窗口大小
let Tlist_Inc_Winwidth=0
let This_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口
"选择代码折叠类型
set foldmethod=syntax
"启动vim时不要自动折叠代码
set foldlevel=100
set scrolloff=10
syntax on "语法高亮"
set nu "显示行号"
"搜索逐字高亮
set hlsearch
"搜索忽略大小写
set ignorecase
set showmatch

set autoindent
"去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限 
set nocompatible
"设置换行自动缩进4个空格,shiftwidth
set sw=4
"设置table=4个空格,tabstop
set ts=4
"复制时通过快捷键F10切换缩进：
if has("autocmd")
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 状态栏
set laststatus=2      " 总是显示状态栏
"设置状态栏颜色高亮
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=black 
"set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\
"开启高亮光标行
set cursorline
"hi CursorLine term=bold cterm=bold guibg=Grey40 guifg=darkred
hi CursorLine   cterm=bold ctermfg=white guibg=darkred guifg=white

"开启高亮光标列
"set cursorcolumn
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

"==========================================
"" FileEncode Settings 文件编码,格式
"==========================================
"设定默认解码"
set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936
set helplang=cn
"实时显示模式
function! CurMode()
let curmode = mode()
if curmode == "i"
   return "INSERT"
elseif curmode == "n"
   return "NORMAL"
else
return "VISUAL"
endfunction
" 获取当前路径，将$HOME转化为~
function! CurDir()
let curdir = substitute(getcwd(), $HOME, "~", "g")
return curdir
endfunction

"==========================================
"HotKey Settings  自定义快捷键设置
"==========================================
"用w代替:w
nmap <leader>w :w<cr>
"用f代替:find
nmap <leader>f :find<cr>
"用q代替:q
nmap <leader>q :q<cr>

" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
" F1 - F6 设置
" F1 废弃这个键,防止调出系统帮助
" F2 行号开关，用于鼠标复制代码用
" F3 显示可打印字符开关
" F4 换行开关
" F5 粘贴模式paste_mode开关,用于有格式的代码粘贴
" F6 语法开关，关闭语法可以加快大文件的展示

" I can type :help on my own, thanks.  Protect your fat fingers from the evils of <F1>
noremap <F1> <Esc>"

""为方便复制，用<F2>开启/关闭行号显示:
function! HideNumber()
  if(&relativenumber == &number)
    set relativenumber! number!
  elseif(&number)
    set number!
  else
    set relativenumber!
  endif
  set number?
endfunc
nnoremap <F2> :call HideNumber()<CR>
nnoremap <F3> :set list! list?<CR>
nnoremap <F4> :set wrap! wrap?<CR>
"set nopaste
set pastetoggle=<F10>

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>
" ex mode commands made easy 用于快速进入命令行


"==========================================
" FileType Settings  文件类型设置
"==========================================
"复制时通过快捷键F8切换g++,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -o %.binary"
    exec "q"
    "exec "!gdb ./%<"
endfunc

"C，C++, shell, python, javascript, ruby...等按F10运行
map <F10> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
        exec "!rm ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
        exec "!rm ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
        exec "!rm ./%<.class"
    elseif &filetype == 'sh'
        exec "!time bash %"
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'html'
        exec "!chrome % &"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd' "MarkDown 解决方案为VIM + Chrome浏览器的MarkDown Preview Plus插件，保存后实时预览
        exec "!chrome % &"
    elseif &filetype == 'javascript'
        exec "!time node %"
    elseif &filetype == 'coffee'
        exec "!time coffee %"
    elseif &filetype == 'ruby'
        exec "!time ruby %"
    endif
endfunc


" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    "如果文件类型为python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    normal G
    normal o
    normal o
endfunc

" Python 文件的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai

" 保存python文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()


"--------------------------------------------------------------
"    Vundle插件配置
"--------------------------------------------------------------
"filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
"call vundle#rc('~/.vim/bundle/vundle')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}
"一个语法检测的插件
Plugin 'scrooloose/syntastic'
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting = 0
"let g:syntastic_python_checker="flake8,pyflakes,pep8,pylint"
let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes,速度比pylint快
let g:syntastic_javascript_checkers = ['jsl', 'jshint']
let g:syntastic_html_checkers=['tidy', 'jshint']
highlight SyntasticErrorSign guifg=white guibg=black

"撰写和使用snippet神器,快速插入自定义的代码片段
"查看文件编辑历史
"g- g+ :earlier :last
Plugin 'SirVer/ultisnips'
map <leader>ud :GundoToggle<CR>
Plugin 'sjl/gundo.vim'

"查看并快速跳转到代码中的TODO列表
Plugin 'vim-scripts/TaskList.vim'

"markdown语法,编辑md文件
let g:vim_markdown_folding_disabled=1
Plugin 'plasticboy/vim-markdown'

"golang语法高亮
Plugin 'jnwhiteh/vim-golang'
"python语法高亮
"
Plugin 'python-syntax'

"多光标批量操作
Plugin 'vim-multiple-cursors'

"输入引号,括号时,自动补全,对python的docstring 三引号做了处理(只处理""", '''暂时没配，可以自己加)
Plugin 'Raimondi/delimitMate'

"快速给词加环绕符号,例如引号
Plugin 'tpope/vim-surround'

"快速批量加减注释
";cc注释当前行,;cA行尾注释,;cu取消注释
let g:NERDSpaceDelims=1
Plugin 'scrooloose/nerdcommenter'

"自动补全插件clang_complete/AutoComplPop/Supertab/neocomplcache/jedi(对python的补全)
"pLUGIN 'valloric/YouCompleteMe'
"跳转到光标后任意位置
let g:EasyMotion_smartcase = 1
" let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
Plugin 'Lokaltog/vim-easymotion'

"括号高亮
Plugin 'kien/rainbow_parentheses.vim'

"状态栏美观
Plugin 'Lokaltog/vim-powerline'

"taglist
Plugin 'vim-scripts/taglist.vim'

"开启目录树导航
Plugin 'scrooloose/nerdtree'
map <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
"let NERDTreeDirArrows=0
"let g:netrw_home='~/bak'
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
" s/v 分屏打开文件
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
