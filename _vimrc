syntax on

set nobackup

" スワップファイルを保存しない
set noswapfile

"タイトル表示
set title

" 補完候補の表示
set wildmenu

" タブの設定
set tabstop=2
set autoindent
set expandtab
set shiftwidth=2

" 行数表示
set number
" 現在のカーソル位置表示
set ruler
" カーソル行の背景を変える→めっちゃ重かった
set cursorline
" 対応する括弧の表示
set showmatch


" バックスペースの設定
set backspace=indent,eol,start
" 上下８行確保
set scrolloff=8

" 検索文字をハイライト
set hlsearch
" 検索で大文字と小文字を区別しない
set ignorecase

" ファイルエンコーディング
set fileencodings=utf-8,sjis,euc-jp,cp932

" ヤンクをクリップボードにもコピー
set clipboard=unnamed

" j,kによる移動を折返されたテキストでも自然に振舞うよう表示？
nnoremap j gj
nnoremap k gk

" Visualモードで選択した範囲を検索
vnoremap * "zy:let @/ = @z<CR>n"

" 折りたたみ
set foldmethod=indent
set foldlevel=3
" set foldcolumn=3
autocmd VimEnter * execute 'set foldlevel=1'


" タブの設定
" Anywhere SID.
function! s:SID_PREFIX()
	return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()
	let s = ''
	for i in range(1, tabpagenr('$'))
		let bufnrs = tabpagebuflist(i)
		let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, firstappears
		let no = i  " display 0-origin tabpagenr.
		let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
		let title = fnamemodify(bufname(bufnr), ':t')
		let title = '[' . title . ']'
		let s .= '%'.i.'T'
		let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
		let s .= no . ':' . title
		let s .= mod
		let s .= '%#TabLineFill# '
	endfor
	let s .= '%#TabLineFill#%T%=%#TabLine#'
	return s
endfunction
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 ""常にタブラインを表示

" The prefix key.
nnoremap    [Tag] <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
	execute 'nnoremap <silent> [Tag]'.n ':<C-u>tabnext'.n.'<CR>'
endfor
" t1で1番左のタブ、t2で1番左から2番目のタブにジャンプ

" map <silent> [Tag]n :tablast <bar> tabnew<CR>
map <silent> [Tag]n :tabnew<CR>
" tn 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]l :tabnext<CR>
" tl 次のタブ
map <silent> [Tag]h :tabprevious<CR>
" th 前のタブ
" ファイルを開いたときに最後にカーソルがあった場所に移動する
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
	\ exe "normal g`\"" | endif
augroup END

" neobundle settings {{{
if has('vim_starting')
  set nocompatible
  " neobundleをインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " neobundle.vim のくろーん
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepathの追加は必須
  set runtimepath +=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'
" }}}


" solarized カラースキーム
NeoBundle 'altercation/vim-colors-solarized'
" mustang カラースキーム
NeoBundle 'croaker/mustang-vim'
" wombat カラースキーム
NeoBundle 'jeffreyiacono/vim-colors-wombat'
" jellybeans カラースキーム
NeoBundle 'nanotech/jellybeans.vim'
" lucius カラースキーム
NeoBundle 'vim-scripts/Lucius'
" zenburn カラースキーム
NeoBundle 'vim-scripts/Zenburn'
" mrkn256 カラースキーム
NeoBundle 'mrkn/mrkn256.vim'
" railscasts カラースキーム
NeoBundle 'jpo/vim-railscasts-theme'
" pyte カラースキーム
NeoBundle 'therubymug/vim-pyte'
" molokai カラースキーム
NeoBundle 'tomasr/molokai'

" カラースキーム一覧表示に Unite.vim を使う
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'

"	NeoBundle 'mattn/emmet-vim'
" vim-rails
NeoBundle 'tpope/vim-rails'
" autoclose 括弧の補完
NeoBundle 'Townk/vim-autoclose'
" NERDTree
NeoBundle 'scrooloose/nerdtree'
" vimshell
 NeoBundle 'Shougo/vimshell'
" vimproc
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \ 'windows' : 'make -f make_mingw32.mak',
      \ 'cygwin' : 'make -f make_cygwin.mak',
      \ 'mac' : 'make -f make_mac.mak',
      \ 'unix' : 'make -f make_unix.mak',
      \ },
\ }
" neocomplcache
 NeoBundle 'Shougo/neocomplcache'

" Coffee Script
NeoBundle 'kchmck/vim-coffee-script'

" Ruby で endを自動挿入してくれる
NeoBundle 'tpope/vim-endwise'

" コメントON/OFFを<C ->×2で実行
NeoBundle "tomtom/tcomment_vim"

" インデント視覚化
NeoBundle 'nathanaelkane/vim-indent-guides'

" sudo.vim
NeoBundle 'sudo.vim'

" fugitive.vim
NeoBundle 'tpope/vim-fugitive'

" ログファイルを色づけしてくれる
NeoBundle 'vim-scripts/AnsiEsc.vim'

" 画面サイズとか変更できる
NeoBundle 'kana/vim-submode'

NeoBundleCheck

call neobundle#end()
filetype plugin indent on

" カラースキーム
colorscheme slate 

" window操作---------------------------------
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H

" vim-submode---------------------------------

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

" -------------------------------------------

" unite {{{
"let g:unite_enable_start_insert=1
"nmap <silent> <C-u><C-b> :<C-u>Unite buffer<CR>
"nmap <silent> <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"nmap <silent> <C-u><C-r> :<C-u>Unite -buffer-name=register register<CR>
"nmap <silent> <C-u><C-m> :<C-u>Unite file_mru<CR>
"nmap <silent> <C-u><C-u> :<C-u>Unite buffer file_mru<CR>
"nmap <silent> <C-u><C-a> :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
"au FileType unite nmap <silent> <buffer> <expr> <C-j> unite#do_action('split')
"au FileType unite imap <silent> <buffer> <expr> <C-j> unite#do_action('split')
"au FileType unite nmap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
"au FileType unite imap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
"au FileType unite nmap <silent> <buffer> <ESC><ESC> q
"au FileType unite imap <silent> <buffer> <ESC><ESC> <ESC>q
" }}}


" zencoding-vim
"let g:user_emmet_leader_key='<TAB>'
"" 言語変更
"let g:user_emmet_settings = {
"			\ 'lang' : 'ja',
"			\ 'html' : {
"			\		'filters' : 'html',
"			\},
"			\ 'css' : {
"			\		'filters' : 'fc',
"			\},
"			\}
"" }

" NERDTreeをデフォルトで起動
" autocmd VimEnter * execute 'NERDTree'

" vimにcoffeeファイルタイプを認識させる
  au BufRead, BufNewFile, BufRadPre *.coffee set filetype=coffee

" Coffeeインデント設定
  autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et

" オートコンパイル
  " 保存と同時にコンパイルする
  autocmd BufWritePost *.coffee silent make!

  " エラーがあったら別ウィンドウで表示
  autocmd QuickFixCmdPost * nested cwindow | redraw!

  " Ctrc-c で右ウィンドウにコンパイル結果を一時表示
  " nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h

" vim起動時にvim-indent-guide ON
let g:indent_guides_enable_on_vim_startup = 1

" vimshell 設定
" ,is:シェルを起動
nnoremap <silent> ,is :VimShellCreate<CR>
" ,ipy pythonを非同期で実行
nnoremap <silent> ,ipy :VimShellInteractive ipython<CR>
" ,irb irbを非同期で実行
nnoremap <silent> ,irb :VimShellInteractive irb<CR>
" ,pry pryを非同期で実行
nnoremap <silent> ,pry :VimShellInteractive pry<CR>
" ,rcs rails console(staging)を非同期で実行
nnoremap <silent> ,rcs :VimShellInteractive rails console staging<CR>
" ,rcd rails console(development)を非同期で実行
nnoremap <silent> ,rcd :VimShellInteractive rails console development<CR>
" ,ss 非同期で開いたインタプリタに現在の行を評価させる
vmap <silent> ,ss :VimShellSendString<CR>
" ,ss 非同期で開いたインタプリタに選択中の行を評価させる
nnoremap <silent> ,ss <S-v>:VimShellSendString<CR>

"" neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : ''
      \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"   
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>" 
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()""

" for Java
NeoBundleLazy 'ervandew/eclim', {'build': {'mac': 'ant-Declipse.home=/opt/homebrew-cask/Caskroom/eclipse-java/4.4.0/eclipse -Dvim.files='.escape(expand('~/.bundle/eclim'), '')}}
autocmd FileType java NeoBundleSource eclim
" Eclim open declaration
nnoremap <silent> ,od :JavaSearchContext<CR>
" open call hierarchy
nnoremap <silent> ,oh :JavaCallHierarchy<CR>
" add import sentences :JavaImportOrganize 
" let g:EclimCompletionMethod = 'g:neocomplcache'
let g:neocomplcache_force_overwrite_completefunc = 1

" 拾い物 http://d.hatena.ne.jp/m1204080/20101025/1288028786
"-----------------------------------------
"カレントウィンドウを新規タブで開き直す
"-----------------------------------------
if v:version >= 700
  nnoremap <C-t> :call OpenNewTab()<CR>
  function! OpenNewTab()
    let f = expand("%:p")
    execute ":q"
    execute ":tabnew ".f
  endfunction
endif

" CrystalのsyntaxをRubyと一緒に
au BufRead *.cr set filetype=ruby

" 補完ポップアップの色
" ノーマルアイテム
hi Pmenu ctermbg=17
" 選択しているアイテム
hi PmenuSel ctermbg=4
" スクロールバー
hi PmenuSbar ctermbg=2
" スクロールのレバー
hi PmenuThumb ctermfg=3

hi Search ctermbg=14 ctermfg=0

" ctags
NeoBundle 'soramugi/auto-ctags.vim'
let g:auto_ctags = 1
