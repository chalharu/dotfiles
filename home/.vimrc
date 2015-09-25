set encoding=utf-8
scriptencoding utf-8

"--------------------
" 基本的な設定
"--------------------
"新しい行のインデントを現在行と同じにする
set autoindent
 
"バックアップファイルのディレクトリを指定する
set backupdir=$HOME/.vimbackup

"Undoファイルのディレクトリを指定
set undodir=$HOME/.vimundo
 
"クリップボードをWindowsと連携する
set clipboard=unnamed
  
"vi互換をオフする
" set nocompatible

"スワップファイル用のディレクトリを指定する
set directory=$HOME/.vimbackup
 
"タブの代わりに空白文字を指定する
set expandtab
     
"変更中のファイルでも、保存しないで他のファイルを表示する
set hidden
      
"インクリメンタルサーチを行う
set incsearch
       
"行番号を表示する
set number
        
"閉括弧が入力された時、対応する括弧を強調する
set showmatch
         
"新しい行を作った時に高度な自動インデントを行う
set smarttab
          
" grep検索を設定する
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh
           
" 検索結果のハイライトをEsc連打でクリアする
nnoremap <ESC><ESC> :nohlsearch<CR>

" "文字コード
" set fencs=iso-2022-jp,sjis,euc-jp

augroup vimrc
  autocmd!
augroup END

" vimgrepやgrep した際に、cwindowしてしまう
autocmd vimrc QuickFixCmdPost *grep* cwindow

" エスケープシーケンスの表示 tab eol
set list
set listchars=tab:▸\ ,eol:¬

" 全角スペースの表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkGray gui=reverse guifg=DarkGray
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        "ZenkakuSpace をカラーファイルで設定するなら、
        "次の行をコメントアウト
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

"
" NeoBundle
"
"
" NeoBundle がインストールされていない時、
" もしくは、プラグインの初期化に失敗した時の処理
function! s:WithoutBundles()
  colorscheme desert
  " その他の処理
endfunction

" NeoBundle よるプラグインのロードと各プラグインの初期化
function! s:LoadBundles()
  " 読み込むプラグインの指定
  NeoBundleFetch 'Shougo/neobundle.vim'
  "NeoBundle 'tpope/vim-surround'
  NeoBundle 'Shougo/vimfiler.vim'
  " ...
  " 読み込んだプラグインの設定
  " ...

  " unite.vim
  NeoBundle 'Shougo/unite.vim'
  " unite {{{
  let g:unite_enable_start_insert=1
  nmap <silent> <C-u><C-b> :<C-u>Unite buffer<CR>
  nmap <silent> <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nmap <silent> <C-u><C-r> :<C-u>Unite -buffer-name=register register<CR>
  nmap <silent> <C-u><C-m> :<C-u>Unite file_mru<CR>
  nmap <silent> <C-u><C-u> :<C-u>Unite buffer file_mru<CR>
  nmap <silent> <C-u><C-a> :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
  autocmd vimrc FileType unite nmap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  autocmd vimrc FileType unite imap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  autocmd vimrc FileType unite nmap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  autocmd vimrc FileType unite imap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  autocmd vimrc FileType unite nmap <silent> <buffer> <ESC><ESC> q
  autocmd vimrc FileType unite imap <silent> <buffer> <ESC><ESC> <ESC>q
  " }}}

  " neomru.vim
  NeoBundle 'Shougo/neomru.vim', {
        \ 'depends' : 'Shougo/unite.vim'
        \ }

  " vimproc
  NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \    },
    \ }

  " neocomplete.vim
  if has('lua')
    NeoBundleLazy 'Shougo/neocomplete.vim', {
                \ 'depends' : 'Shougo/vimproc',
                \ 'autoload' : { 'insert' : 1,}
                \ }
  endif

  " neocomplete {{{
  let g:neocomplete#enable_at_startup               = 1
  let g:neocomplete#auto_completion_start_length    = 3
  let g:neocomplete#enable_ignore_case              = 1
  let g:neocomplete#enable_smart_case               = 1
  let g:neocomplete#enable_camel_case               = 1
  let g:neocomplete#use_vimproc                     = 1
  let g:neocomplete#sources#buffer#cache_limit_size = 1000000
  let g:neocomplete#sources#tags#cache_limit_size   = 30000000
  let g:neocomplete#enable_fuzzy_completion         = 1
  let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
  " }}}

  " vimshell
  NeoBundleLazy 'Shougo/vimshell', {
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : {
    \   'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
    \                 'VimShellExecute', 'VimShellInteractive',
    \                 'VimShellTerminal', 'VimShellPop'],
    \   'mappings' : ['<Plug>(vimshell_switch)']
    \ }}

  " vimshell {{{
  nmap <silent> vs :<C-u>VimShell<CR>
  nmap <silent> vp :<C-u>VimShellPop<CR>
  " }}}

  "yankround
  NeoBundle 'LeafCage/yankround.vim'

  " yankround.vim {{{
  nmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)
  let g:yankround_max_history = 100
  nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>
  "}}}
  
  NeoBundleLazy 'Shougo/vimfiler', {
    \ 'depends' : ["Shougo/unite.vim"],
    \ 'autoload' : {
    \   'commands' : [ "VimFilerTab", "VimFiler", "VimFilerExplorer", "VimFilerBufferDir" ],
    \   'mappings' : ['<Plug>(vimfiler_switch)'],
    \   'explorer' : 1,
    \ }}


  " vimfiler {{{
  let g:vimfiler_as_default_explorer  = 1
  let g:vimfiler_safe_mode_by_default = 0
  let g:vimfiler_data_directory       = expand('~/.vim/etc/vimfiler')
  nnoremap <silent><C-u><C-j> :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit -toggle<CR>
  " }}}

  NeoBundle 'Townk/vim-autoclose'

  NeoBundleLazy 'tpope/vim-endwise', {
    \ 'autoload' : { 'insert' : 1,}}

  NeoBundle 'glidenote/memolist.vim'

  " memolist {{{
  let g:memolist_path = expand('~/Dropbox/memolist')
  let g:memolist_gfixgrep = 1
  let g:memolist_unite = 1
  let g:memolist_unite_option = '-vertical -start-insert'
  nnoremap mn  :MemoNew<CR>
  nnoremap ml  :MemoList<CR>
  nnoremap mg  :MemoGrep<CR>
  " }}}

  NeoBundle 'Lokaltog/vim-easymotion'
  " vim-easymotion {{{
  let g:EasyMotion_do_mapping = 0
  nmap s <Plug>(easymotion-s2)
  xmap s <Plug>(easymotion-s2)
  omap z <Plug>(easymotion-s2)
  nmap g/ <Plug>(easymotion-sn)
  xmap g/ <Plug>(easymotion-sn)
  omap g/ <Plug>(easymotion-tn)
  let g:EasyMotion_smartcase = 1
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)
  let g:EasyMotion_startofline = 0
  let g:EasyMotion_keys = 'QZASDFGHJKL;'
  let g:EasyMotion_use_upper = 1
  let g:EasyMotion_enter_jump_first = 1
  " }}}

  NeoBundleLazy 'junegunn/vim-easy-align', {
    \ 'autoload': {
    \   'commands' : ['EasyAlign'],
    \   'mappings' : ['<Plug>(EasyAlign)'],
    \ }}

  " vim-easy-align {{{
  vmap <Enter> <Plug>(EasyAlign)
  nmap <Leader>a <Plug>(EasyAlign)
  " }}}

  NeoBundle 'rcmdnk/vim-markdown'
  " vim-markdown {{{
  let g:vim_markdown_folding_disabled = 1
  " }}}

  NeoBundle 'haya14busa/incsearch.vim'
  " insearch {{{
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  " }}}


endfunction

" NeoBundle がインストールされているなら LoadBundles() を呼び出す
" そうでないなら WithoutBundles() を呼び出す
function! s:InitNeoBundle()
  if !isdirectory(expand('~/.vim/bundle/neobundle.vim/'))
    echo 'install neobundle...'
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    call system('git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim')
  endif

  filetype plugin indent off
  if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif
  try
    call neobundle#begin(expand('~/.vim/bundle/'))
    call s:LoadBundles()
    call neobundle#end()
    filetype indent plugin on
    NeoBundleCheck
  catch
    call s:WithoutBundles()
  endtry 

  filetype indent plugin on
  syntax on
endfunction

call s:InitNeoBundle()

