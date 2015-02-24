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
" set cursorline
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


" カラースキーム
colorscheme slate 

" j,kによる移動を折返されたテキストでも自然に振舞うよう表示？
nnoremap j gj
nnoremap k gk

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

" zencoding-vim
let g:user_emmet_leader_key='<TAB>'
" 言語変更
let g:user_emmet_settings = {
			\ 'lang' : 'ja',
			\ 'html' : {
			\		'filters' : 'html',
			\},
			\ 'css' : {
			\		'filters' : 'fc',
			\},
			\}
" }

" ファイルを開いたときに最後にカーソルがあった場所に移動する
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
	\ exe "normal g`\"" | endif
augroup END

" neobundle setting
set nocompatible
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin('~/.vim/bundle')
  NeoBundleFetch 'Shougo/neobundle.vim'
  call neobundle#end()
endif

" end neobundle setting


" NERDTreeをデフォルトで起動
autocmd VimEnter * execute 'NERDTree'

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

	NeoBundle 'mattn/emmet-vim'
" vim-rails
	NeoBundle 'tpope/vim-rails'
" autoclose 括弧の補完
	NeoBundle 'Townk/vim-autoclose'
" NERDTree
  NeoBundle 'scrooloose/nerdtree'
" vimshell
  NeoBundle 'Shougo/vimshell'
" vimproc
"  NeoBundle 'Shougo/vimproc'
" neocomplete
"  NeoBundle 'Shougo/neocomplete.vim'

" Coffee Script
  NeoBundle 'kchmck/vim-coffee-script'
" vimにcoffeeファイルタイプを認識させる
  au BufRead, BufNewFile, BufRadPre *.coffee set filetype=coffee


" インデント設定
  autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
