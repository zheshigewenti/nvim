" _           _   _                 _
"(_)  _ __   (_) | |_      __   __ (_)  _ __ ___
"| | | '_ \  | | | __|     \ \ / / | | | '_ ` _ \
"| | | | | | | | | |_   _   \ V /  | | | | | | | |
"|_| |_| |_| |_|  \__| (_)   \_/   |_| |_| |_| |_|
"
" Author: @zheshigewenti

" ==================== Auto load for first time uses ====================
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:nvim_plugins_installation_completed=1
if empty(glob($HOME.'/.config/nvim/plugged/wildfire.vim/autoload/wildfire.vim'))
	let g:nvim_plugins_installation_completed=0
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location "自定义相关库路径
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source $HOME/.config/nvim/_machine_specific.vim

" === Settings
" set guifont=Microsoft_YaHei_Mono:h11:cANSI
set guifont=wqy-microhei_Mono
" set confirm  "未保存提示确认
set clipboard=unnamedplus " 系统剪切板共享
set autochdir  "在当前dir下执行命令
set number     " 行号显示
set relativenumber " 相对行号显示
set cursorline " 打开所在行光标线
set noexpandtab  "关闭tab转空格
set tabstop=2  "<tab>缩进距离为2
set shiftwidth=2
set softtabstop=2
set autoindent  "自动缩进
set list  "显示行尾空格
set listchars=tab:\|\ ,trail:▫ "显示空格样式
set scrolloff=4   "滚动时上下预留4行
set ttimeoutlen=0
set notimeout  "不设置超时
set viewoptions=cursor,folds,slash,unix
set wrap    " 文字超出显示时自动换行
set tw=0
set indentexpr=  "不使用表达式缩进
set foldmethod=indent  "折叠方式
set foldlevel=99  "折叠级别
set foldenable  "允许折叠
set formatoptions-=tc "文本格式
set splitright  "新窗口光标默认位置在右
set splitbelow  "新窗口光标默认位置在下
set noshowmode " 不显示当前模式
set showcmd    " 输入命令显示
set wildmenu   " 命令行输入按<tab>提供补全菜单
set ignorecase " 忽略大小写
set smartcase  " 智能区分大小写
set shortmess+=c  "提示消息
set inccommand=split  "命令执行时打开新窗口
set completeopt=longest,noinsert,menuone,noselect,preview  "vim自带补全
set ttyfast "让滚动更快
set lazyredraw "same as above
set visualbell
" 退出vim之后再进入仍保存修改历史
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif
" set colorcolumn=155  "位置可视化
set updatetime=1000  "更新时间
set virtualedit=block
"打开vim会把光标放在上次编辑的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" ===Mappings
" Set <LEADER> as <SPACE>, ; as :  "设置<LEADER>等于空格,;等于:
let &t_ut=''  "校准vim配色
let mapleader=" "

" quit & save
noremap Q :q<CR>
noremap S :w<CR>

" Open the vimrc file anytime  "快速打开init.vim
noremap <LEADER>in :e ~/.config/nvim/init.vim<CR>

" Open Startify
"noremap <LEADER>st :Startify<CR>

" make Y to copy till the end of the line & Copy to system clipboard "Y复制至行尾巴&复制到系统剪切板
nnoremap Y y$
vnoremap Y "+y

" Search  "取消搜索高亮
noremap <LEADER><CR> :nohlsearch<CR>

" Space to Tab  "块模式下空格转制表符
vnoremap <LEADER>pp :s/    /\t/g

"K/J keys for 5 times k/j (faster navigation)
noremap <silent> K 5k
noremap <silent> J 5j

" H key: go to the start of the line  "普通模式下H移动到行首
noremap <silent> H 0
" L key: go to the end of the line  "普通模式下L移动到行尾
noremap <silent> L $

" === Insert Mode Cursor Movement  "插入模式移动光标至行尾
inoremap <C-a> <ESC>A

" Use <space> + new arrow keys for moving the cursor around windows "窗口间移动
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l

" Disable the default s key  "取消s&ZZ的原本作用
noremap s <nop>
noremap ZZ <nop>

" noremap sl :set splitbelow<CR>:split<CR>  "分裂窗口
noremap <leader>sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys  "窗口分界线左右移动
noremap <left>  :vertical resize+5<CR>
noremap <right> :vertical resize-5<CR>

" Create a new tab with tu  "打开新标签页
noremap tu :tabe<CR>
" Move around tabs with tn and ti  "标签页间切换
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>

" Snippets  "片段源路径
source ~/.config/nvim/md-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell


" ==================== Other useful stuff ====================
" Opening a terminal window  "快速打开内置终端
noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>
" Press space twice to jump to the next '<++>' and edit it "空格速度跳转到<++>
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
" Spelling Check with <space>sc  "拼写检查
noremap <LEADER>sc :set spell!<CR>
" Press ` to change case (instead of ~)
noremap ` ~
" Auto change directory to current dir  "自动改变文件夹位置到当前文件夹
autocmd BufEnter * silent! lcd %:p:h
" Call figlet  "无花果字体
noremap tx :r !figlet 
" find and replace "查找替换
noremap \s :%s//<left>
" set wrap
noremap <LEADER>sw :set wrap<CR>
" press f10 to show hlgroup
" function! SynGroup()
" 	let l:s = synID(line('.'), col('.'), 1)
" 	echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
" endfun
map <F10> :TSHighlightCapturesUnderCursor<CR>

" Compile function  "编译函数 eg. r自动写入预览.md文件
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		set splitbelow
		:sp
		:res -5
		term gcc % -o %< && time ./%<
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'cs'
		set splitbelow
		silent! exec "!mcs %"
		:sp
		:res -5
		:term mono %<.exe
	elseif &filetype == 'java'
		set splitbelow
		:sp
		:res -5
		term javac % && time java %<
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'racket'
		set splitbelow
		:sp
		:res -5
		term racket %
	elseif &filetype == 'go'
		set splitbelow
	  :sp
		:term go run .
	endif
endfunc


" ==================== Install Plugins with Vim-Plug ====================
call plug#begin('$HOME/.config/nvim/plugged')


" Github Copilot
" Plug 'github/copilot.vim'

" Treesitter  用于代码突出显示
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'

" Vim Theme
Plug 'sainnhe/everforest'
Plug 'itchyny/lightline.vim'

" General Highlighter  可视化调色板
Plug 'NvChad/nvim-colorizer.lua'
Plug 'RRethy/vim-illuminate'

" File navigation  文件搜索导航
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  "fzf主库
Plug 'junegunn/fzf.vim'  "依赖于fzf
Plug 'theniceboy/joshuto.nvim'  "可在浮动窗口中使用joshuto
Plug 'airblade/vim-rooter'  "当跳转文件时把工作目录设置为当前已打开文件目录
Plug 'pechorin/any-jump.vim'  "关键词跳转文件

" Debugger
" Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python --enable-go'}

" Auto Complete  自动补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'wellle/tmux-complete.vim'

" Snippets
" Plug 'SirVer/ultisnips'
Plug 'theniceboy/vim-snippets'  "自定义片段

" Undo Tree
Plug 'mbbill/undotree'  "撤销树

" Git
Plug 'theniceboy/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
Plug 'theniceboy/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
"Plug 'mhinz/vim-signify'
Plug 'lewis6991/gitsigns.nvim'  "git标记
Plug 'kdheepak/lazygit.nvim'  "<c-g>打开lazygit

" Tex
Plug 'lervag/vimtex'
" CSharp
Plug 'OmniSharp/omnisharp-vim'
Plug 'ctrlpvim/ctrlp.vim' , { 'for': ['cs', 'vim-plug'] } " omnisharp-vim dependency

" HTML, CSS, JavaScript, Typescript, PHP, JSON, etc.
Plug 'elzr/vim-json'
Plug 'neoclide/jsonc.vim'
Plug 'othree/html5.vim'
Plug 'alvan/vim-closetag'
" Plug 'hail2u/vim-css3-syntax' " , { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
" Plug 'pangloss/vim-javascript', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Plug 'jelera/vim-javascript-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"Plug 'jaxbot/browserlink.vim'
Plug 'HerringtonDarkholme/yats.vim'
" Plug 'posva/vim-vue'
" Plug 'evanleck/vim-svelte', {'branch': 'main'}
" Plug 'leafOfTree/vim-svelte-plugin'
" Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'pantharshit00/vim-prisma'

" Go
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }  "python缩进
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }  "python语义高亮
Plug 'tweekmonster/braceless.vim', { 'for' :['python', 'vim-plug'] }
"Plug 'vim-scripts/indentpython.vim', { 'for' :['python', 'vim-plug'] }
"Plug 'plytophogy/vim-virtualenv', { 'for' :['python', 'vim-plug'] }
"Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }

" Dart
" Plug 'dart-lang/dart-vim-plugin', { 'for': ['dart', 'vim-plug'] }

" Swift
" Plug 'keith/swift.vim'
" Plug 'arzg/vim-swift'

" Markdown
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}  "markdown浏览器自动预览
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }  "markdown表格自动对齐
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }  " :GenTocGFM :GenTocRedcarpet :GenTocGitLab :GenTocMarked 生成所需类型的md目录
Plug 'dkarter/bullets.vim' " 1. * - 自动格式

" Other filetypes  其他文件类型
Plug 'wlangstroth/vim-racket'  "为 Racket 文件启用自动检测、缩进和语法突出显示
" Plug 'jceb/vim-orgmode', {'for': ['vim-plug', 'org']}
Plug 'hashivim/vim-terraform'  "调用terraform管理工具

" Editor Enhancement  编辑器增强
Plug 'petertriho/nvim-scrollbar'  "右侧滚动条
Plug 'kevinhwang91/nvim-hlslens'  "搜索高亮
"Plug 'Raimondi/delimitMate'
Plug 'tomtom/tcomment_vim'  "<c-/>在行首加注释符号
Plug 'jiangmiao/auto-pairs'  "成对删除括号&引号
Plug 'mg979/vim-visual-multi' "<c-n>进入多光标模式
Plug 'theniceboy/antovim' " gs切换false或true
Plug 'tpope/vim-surround' "<CR>S' 用''把句子包裹 or cs'`让'word'变成`word`
Plug 'gcmt/wildfire.vim'  "<CR>选中双引号中所有东西
Plug 'junegunn/vim-after-object' " da=删除da=后的代码
Plug 'godlygeek/tabular'  "tb纠正代码格式
Plug 'tpope/vim-capslock' " <C-G>c切换大小写
" Plug 'Konfekt/FastFold'
"Plug 'junegunn/vim-peekaboo'
"Plug 'wellle/context.vim'
Plug 'svermeulen/vim-subversive'  "sw覆盖想要替换的单词,si符号 覆盖你想要覆盖的符号内容
Plug 'theniceboy/argtextobj.vim'  "参数文本对象
Plug 'rhysd/clever-f.vim'  "快速跳转
Plug 'AndrewRadev/splitjoin.vim' "gS将单行拆分为多行 gJ(光标位于块的第一行)将块连接成单行语句
Plug 'matze/vim-move'  "<c-j><c-k>交换上下两行
" Plug 'jeffkreeftmeijer/vim-numbertoggle'
" Plug 'Yggdroot/indentLine'

" For general writing  一般写作
Plug 'junegunn/goyo.vim'  "沉浸式预览
Plug 'reedes/vim-wordy'  "查找显示多次重复的单词
"Plug 'ron89/thesaurus_query.vim'

" Bookmarks  书签
" Plug 'MattesGroeger/vim-bookmarks'

" Find & Replace  查找&替换
Plug 'nvim-lua/plenary.nvim' " nvim-spectre dep
Plug 'nvim-pack/nvim-spectre'  "查找替换

" Documentation
" Plug 'KabbAmine/zeavim.vim' " <LEADER>z to find doc

" Mini Vim-APP
"Plug 'jceb/vim-orgmode'
"Plug 'mhinz/vim-startify'
Plug 'skywind3000/asynctasks.vim'  "异步运行命令
Plug 'skywind3000/asyncrun.vim'

" Vim Applications
Plug 'itchyny/calendar.vim'  "日历&闹钟

" Other visual enhancement
Plug 'luochen1990/rainbow'  "彩虹括弧
Plug 'mg979/vim-xtabline'  "标题栏
Plug 'ryanoasis/vim-devicons'  "插件图标
Plug 'wincent/terminus'  "term
Plug 'kyazdani42/nvim-web-devicons'  "图标

" Other useful utilities
Plug 'lambdalisue/suda.vim'  " :sw sudo写入
" Plug 'makerj/vim-pdf'

"fcitx5
Plug 'lilydjwg/fcitx.vim'  "优化vim中英文输入法切换逻辑
call plug#end()

set re=0

" ================= vim theme ===========================
if has('termguicolors')
  set termguicolors
endif
let g:everforest_background = 'medium'  "颜色对比度
let g:everforest_transparent_background = 1  "主题透明度
let g:everforest_current_word = '' "光标当前选项是否突出
let g:lightline = {'colorscheme' : 'everforest'}  "vim状态栏
set background=dark  "主题背景颜色

silent! color everforest
" ==================== Terminal Behaviors ====================
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert  "打开term之后直接进入插入模式


" ===================== Start of Plugin Settings =====================


" ==================== gitsigns.nvim ====================
lua <<EOF
require('gitsigns').setup({
	signs = {
    add          = { hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
    change       = { hl = 'GitSignsChange', text = '|', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    untracked    = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
  },
})
EOF

" ==================== coc.nvim ====================
let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-diagnostic',
	\ 'coc-docker',
	\ 'coc-eslint',
	\ 'coc-explorer',
	\ 'coc-flutter-tools',
	\ 'coc-gitignore',
	\ 'coc-html',
	\ 'coc-import-cost',
	\ 'coc-java',
	\ 'coc-jest',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-omnisharp',
	\ 'coc-prettier',
	\ 'coc-prisma',
	\ 'coc-pyright',
	\ 'coc-snippets',
	\ 'coc-sourcekit',
	\ 'coc-stylelint',
	\ 'coc-syntax',
	\ 'coc-tasks',
	\ 'coc-translator',
	\ 'coc-tsserver',
	\ 'coc-vetur',
	\ 'coc-vimlsp',
	\ 'coc-yaml',
	\ 'coc-vimtex',
	\ 'coc-yank']

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <c-o> coc#refresh()
function! Show_documentation()
	call CocActionAsync('highlight')
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
nnoremap <LEADER>H :call Show_documentation()<CR>
" set runtimepath^=~/.config/nvim/coc-extensions/coc-flutter-tools/
" let g:coc_node_args = ['--nolazy', '--inspect-brk=6045']
" let $NVIM_COC_LOG_LEVEL = 'debug'
" let $NVIM_COC_LOG_FILE = '/Users/david/Desktop/log.txt'

nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<cr>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nnoremap <c-c> :CocCommand<CR>
" Text Objects
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap tt :CocCommand explorer<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>aw  <Plug>(coc-codeaction-selected)w
" coctodolist
" nnoremap <leader>tn :CocCommand todolist.create<CR>
" nnoremap <leader>tl :CocList todolist<CR>
" nnoremap <leader>tu :CocCommand todolist.download<CR>:CocCommand todolist.upload<CR>
" coc-tasks
noremap <silent> <leader>ts :CocList tasks<CR>
" coc-snippets
imap <C-e> <Plug>(coc-snippets-expand)
vmap <C-s> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-l>'
let g:coc_snippet_prev = '<c-h>'
imap <C-e> <Plug>(coc-snippets-expand-jump)
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc


" ==================== joshuto.nvim ====================
noremap <A-j> :Joshuto<CR>

" ==================== vim-instant-markdown ====================
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 0
let g:instant_markdown_browser = "chromium --new-window"
" let g:instant_markdown_open_to_the_world = 1
" let g:instant_markdown_allow_unsafe_content = 1
" let g:instant_markdown_allow_external_content = 0
" let g:instant_markdown_mathjax = 1


" ==================== vim-table-mode ====================
noremap <LEADER>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'


" ==================== FZF ====================
noremap <A-f> :Files/<CR>
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6} }

" ==================== CTRLP (Dependency for omnisharp) ====================
let g:ctrlp_map = ''
let g:ctrlp_cmd = 'CtrlP'

" ==================== wildfire ====================
let g:wildfire_objects = {
    \ "*" : ["i'", 'i"', "i)", "i]", "i}", "it"],
    \ "html,xml" : ["at", "it"],
\ }


" ==================== Undotree ====================
noremap TT :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
	nmap <buffer> k <plug>UndotreeNextState
	nmap <buffer> j <plug>UndotreePreviousState
	nmap <buffer> K 5<plug>UndotreeNextState
	nmap <buffer> J 5<plug>UndotreePreviousState
endfunc


" ==================== vim-visual-multi ====================
let g:VM_leader                     = {'default': ',', 'visual': ',', 'buffer': ','}


" ==================== nvim-spectre ====================
nnoremap <LEADER>rp <cmd>lua require('spectre').open()<CR>
vnoremap <LEADER>rp <cmd>lua require('spectre').open_visual()<CR>


" ==================== Bullets.vim ====================
let g:bullets_enabled_file_types = [
			\ 'markdown',
			\ 'text',
			\ 'gitcommit',
			\ 'scratch'
			\]


" ==================== fzf-gitignore ====================
noremap <LEADER>gi :FzfGitignore<CR>


" ==================== VimTex ====================
syntax enable
filetype plugin indent on
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode = 0
" ==================== Ultisnips ====================
" let g:tex_flavor = "latex"
" inoremap <c-n> <nop>
" let g:UltiSnipsExpandTrigger="<c-e>"
" let g:UltiSnipsJumpForwardTrigger="<c-e>"
" let g:UltiSnipsJumpBackwardTrigger="<c-n>"
" let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips/']
" silent! au BufEnter,BufRead,BufNewFile * silent! unmap <c-r>
" " Solve extreme insert-mode lag on macOS (by disabling autotrigger)
" augroup ultisnips_no_auto_expansion
"     au!
"     au VimEnter * au! UltiSnips_AutoTrigger
" augroup END


" ==================== vim-calendar ====================
noremap \\ :Calendar -view=clock -position=here<CR>
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1


" ==================== vim-go ====================
let g:go_echo_go_info = 0
let g:go_doc_popup_window = 1
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
let g:go_doc_keywordprg_enabled = 0


" ==================== OmniSharp ====================
let g:OmniSharp_typeLookupInPreview = 1
let g:omnicomplete_fetch_full_documentation = 1
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlight_types = 2
let g:OmniSharp_selector_ui = 'ctrlp'
autocmd Filetype cs nnoremap <buffer> gd :OmniSharpPreviewDefinition<CR>
autocmd Filetype cs nnoremap <buffer> gr :OmniSharpFindUsages<CR>
autocmd Filetype cs nnoremap <buffer> gy :OmniSharpTypeLookup<CR>
autocmd Filetype cs nnoremap <buffer> ga :OmniSharpGetCodeActions<CR>
autocmd Filetype cs nnoremap <buffer> <LEADER>rn :OmniSharpRename<CR><C-N>:res +5<CR>
sign define OmniSharpCodeActions text=💡
let g:coc_sources_disable_map = { 'cs': ['cs', 'cs-1', 'cs-2', 'cs-3'] }


" ==================== goyo ====================
map <LEADER>gy :Goyo<CR>


" ==================== jsx ====================
let g:vim_jsx_pretty_colorful_config = 1


" ==================== tabular ====================
vmap tb :Tabularize /


" ==================== vim-after-object ====================
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')


" ==================== rainbow ====================
let g:rainbow_active = 1

" ==================== xtabline ====================
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
noremap to :XTabCycleMode<CR>
noremap \p :echo expand('%:p')<CR>


" ==================== context.vim ====================
"let g:context_add_mappings = 0
"noremap <leader>ct :ContextToggle<CR>


" ==================== suda.vim ====================
cnoreabbrev sw w suda://%


" ==================== vimspector ====================
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
	" has to be a function to avoid the extra space fzf#run insers otherwise
	execute '0r ~/.config/nvim/sample_vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'ls -1 ~/.config/nvim/sample_vimspector_json',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })
" noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=☛ texthl=Normal
sign define vimspectorBPDisabled text=☞ texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad


" ==================== vim-markdown-toc ====================
"let g:vmt_auto_update_on_save = 0
"let g:vmt_dont_insert_fence = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'



" ==================== vim-subversive ====================
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)


" ==================== vim-illuminate ====================
let g:Illuminate_delay = 750
hi illuminatedWord cterm=undercurl gui=undercurl


" ==================== vim-rooter ====================
let g:rooter_patterns = ['__vim_project_root', '.git/']
let g:rooter_silent_chdir = 1


" ==================== AsyncRun ====================
noremap make :AsyncRun make<CR>
noremap gl :AsyncRun -cwd=<$(VIM_ROOT)> git clone 

" ==================== AsyncTasks ====================
let g:asyncrun_open = 6


" ==================== vim-move ====================
let g:move_key_modifier = 'c'


" ==================== any-jump ====================
nnoremap <leader>jm :AnyJump<CR>
let g:any_jump_disable_default_keybindings = 1
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9


" ==================== typescript-vim ====================
let g:typescript_ignore_browserwords = 1


" ==================== nvim-treesitter ====================
if g:nvim_plugins_installation_completed == 1
lua <<EOF
require'nvim-treesitter.configs'.setup {
	-- one of "all", "language", or a list of languages
	ensure_installed = {"typescript", "dart", "java", "c", "prisma", "bash", "go"},
	highlight = {
		enable = true,              -- false will disable the whole extension
		disable = { "rust" },  -- list of language that will be disabled
	},
}
EOF
endif


" ==================== nvim-scrollbar ====================
if g:nvim_plugins_installation_completed == 1
lua <<EOF
require("scrollbar").setup()
require("scrollbar.handlers.search").setup()
require("scrollbar").setup({
	show = true,
	handle = {
		color = "#928374",
		hide_if_all_visible = true,
	},
	marks = {
		Cursor = {text = " "},
		Search = {text = {"•"}, color = "yellow" },
		Misc = { color = "purple" },
	},
	handlers = {
		diagnostic = true,
		gitsigns = false,
		handle = true,
		search = true,
	},
})
EOF
endif


" ==================== nvim-hlslens ====================
noremap <silent> = <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> - <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>



" ==================== lazygit.nvim ====================
noremap <A-g> :LazyGit<CR>
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 1.0 " scaling factor for floating window
let g:lazygit_floating_window_border_chars= ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
let g:lazygit_use_neovim_remote = 1 " for neovim-remote support


" ==================== copilot.nvim ====================
let g:copilot_enabled = 1
nnoremap <silent> <leader>go :Copilot<CR>
nnoremap <silent> <leader>ge :Copilot enable<CR>
nnoremap <silent> <leader>gd :Copilot disable<CR>
" inoremap <c-p> <Plug>(copilot-suggest)
imap <silent><script><expr> <C-C> copilot#Accept("")
let g:copilot_no_tab_map = v:true
inoremap <c-n> <Plug>(copilot-next)
inoremap <c-l> <Plug>(copilot-previous)


" ==================== nvim-colorizer.lua ====================
lua <<EOF
require("colorizer").setup {
	filetypes = { "*" },
	user_default_options = {
		RGB = true, -- #RGB hex codes
		RRGGBB = true, -- #RRGGBB hex codes
		names = false, -- "Name" codes like Blue or blue
		RRGGBBAA = false, -- #RRGGBBAA hex codes
		AARRGGBB = true, -- 0xAARRGGBB hex codes
		rgb_fn = false, -- CSS rgb() and rgba() functions
		hsl_fn = false, -- CSS hsl() and hsla() functions
		css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		-- Available modes for `mode`: foreground, background,  virtualtext
		mode = "virtualtext", -- Set the display mode.
		-- Available methods are false / true / "normal" / "lsp" / "both"
		-- True is same as normal
		tailwind = false, -- Enable tailwind colors
		-- parsers can contain values used in |user_default_options|
		sass = { enable = false, parsers = { css }, }, -- Enable sass colors
		virtualtext = "■",
	},
	-- all the sub-options of filetypes apply to buftypes
	buftypes = {},
}
EOF


" ==================== dart-vim-plugin ====================
let g:dart_corelib_highlight = v:false
let g:dart_format_on_save = v:false


" ===================== End of Plugin Settings =====================

" ===
" === Necessary Commands to Execute
" ===
exec "nohlsearch"
func! s:transparent_background()
    highlight Normal guibg=None ctermbg=None
    highlight NonText guibg=None ctermbg=None
endf
autocmd ColorScheme * call s:transparent_background()

" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
	exec "e ~/.config/nvim/_machine_specific.vim"
endif
