let g:mapleader = ","
let s:cache_dir = "~/.vim/.cache/"

if has("shada")
  set shada=!,'1000,<50,s10,h
endif

set encoding=utf-8 " set encoding for text
set dictionary=/usr/share/dict/words

" prefer locally installed python
if executable("/usr/local/bin/python")
  let g:python_host_prog = "/usr/local/bin/python"
endif

if executable("/usr/local/bin/python3")
  let g:python3_host_prog = "/usr/local/bin/python3"
endif

function! GetCacheDir(suffix)
  return resolve(expand(s:cache_dir . a:suffix))
endfunction

function! s:ensure_exists(path)
  if !isdirectory(expand(a:path))
    call mkdir(expand(a:path))
  endif
endfunction

call s:ensure_exists(s:cache_dir)

" persistent undo
if has("persistent_undo")
  set undofile
  let &undodir=GetCacheDir("undo")
  call s:ensure_exists(&undodir)
endif

" backups
set backup
let &backupdir=GetCacheDir("backup")
call s:ensure_exists(&backupdir)

" swap files
let &directory=GetCacheDir("swap")
call s:ensure_exists(&directory)

if has('termguicolors')
  " belongs in 'gui' but has to be set before plugins are loaded
  set termguicolors

  if !has('nvim')
    let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
    let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
  endif
endif

augroup MyAutoCmd
  autocmd!
augroup END
