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

" j,kによる移動を折返されたテキストでも自然に振舞うよう表示？
nnoremap j gj
nnoremap k gk

" Visualモードで選択した範囲を検索
vnoremap * "zy:let @/ = @z<CR>n"

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

map <silent> [Tag]n :tablast <bar> tabnew<CR>
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
NeoBundle 'Shougo/vimproc'
" neocomplete
"  NeoBundle 'Shougo/neocomplete.vim'

" Coffee Script
NeoBundle 'kchmck/vim-coffee-script'

" Ruby で endを自動挿入してくれる
NeoBundle 'tpope/vim-endwise'

" コメントON/OFFを<C ->×2で実行
NeoBundle "tomtom/tcomment_vim"

" インデント視覚化
NeoBundle 'nathanaelkane/vim-indent-guides'

NeoBundleCheck

call neobundle#end()
filetype plugin indent on

" カラースキーム
colorscheme slate 

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
"

" NERDTreeをデフォルトで起動
  autocmd VimEnter * execute 'NERDTree'

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
