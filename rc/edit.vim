set smarttab
set expandtab
set shiftround
set modeline

" use clipboard register
set clipboard=unnamed

set backspace=indent,eol,start  " allow backspace in insert mode
set noshowmatch                 " don't show matching brackets
set cpoptions-=m
set matchtime=2                 " tens of a second to show matching parentheses
set matchpairs+=<:>
set hidden               " hide buffers when they are abandoned
set autoread             " reload files changed outside vim
set infercase " ignore case on insert completion

if executable("rg")
  set grepprg=rg\ --no-heading\ --vimgrep\ --smart-case\ --follow
  set grepformat=%f:%l:%c:%m
elseif executable("ag")
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -inH
endif

set isfname-== " exclude = from isfilename.

set timeout timeoutlen=3000 ttimeoutlen=100
set updatetime=500
set virtualedit=block

" check timestamp more for 'autoread'
autocmd MyAutoCmd WinEnter * checktime

" disable paste
autocmd MyAutoCmd InsertLeave * if &paste | set nopaste mouse=a | echo 'nopaste' | endif

" update diff
autocmd MyAutoCmd InsertLeave * if &l:diff | diffupdate | endif

set autoindent
set nrformats-=octal " always assume decimal numbers

set formatoptions=croqlt

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

set textwidth=80
set shiftwidth=2
set tabstop=2
set softtabstop=2
set nojoinspaces
set smartindent
set nocopyindent

" search
set ignorecase " case insensitive matching
set smartcase  " smart case matching
set incsearch  " incremental search
set hlsearch
set wrapscan

set tags=./tags;/,~/.vimtags

" make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system("git rev-parse --show-toplevel"), '[\n\r]', "", "g")
if gitroot != ""
  let &tags = &tags . "," . gitroot . "/.git/tags"
endif

" make directory automatically
autocmd MyAutoCmd BufWritePre * call rubix#mkdir(expand('<afile>:p:h'), v:cmdbang)

" go back to previous position of cursor if any
autocmd MyAutoCmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \  execute 'normal! g`"zvzz' |
  \ endif

" automatically strip whitespace trailing on save for these files (add "let
" b:auto_strip_trailing_whitespace = 1" in ftplugin files to enable)
autocmd MyAutoCmd BufWritePre * call rubix#auto_trim()

command! -nargs=* Only call rubix#only()
command! Kwbd call rubix#kwbd(1)
