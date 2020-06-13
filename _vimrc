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

filetype plugin indent on

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

" call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
" call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
" call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
" call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
" call submode#map('bufmove', 'n', '', '>', '<C-w>>')
" call submode#map('bufmove', 'n', '', '<', '<C-w><')
" call submode#map('bufmove', 'n', '', '+', '<C-w>+')
" call submode#map('bufmove', 'n', '', '-', '<C-w>-')

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
  " autocmd BufWritePost *.coffee silent make!

  " エラーがあったら別ウィンドウで表示
  " autocmd QuickFixCmdPost * nested cwindow | redraw!

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

