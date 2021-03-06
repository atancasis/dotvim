" settings after plugins are loaded

" install missing plugins on start
autocmd MyAutoCmd VimEnter *
  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall
  \| endif

if g:rubix_complete == 'deoplete'
  call deoplete#custom#set('_', 'converters',
        \ ['converter_auto_paren',
        \  'converter_auto_delimiter',
        \  'converter_remove_overlap'])
endif

if g:rubix_snippet == 'neosnippet'
  let g:neosnippet#snippets_directory = globpath(&rtp, "snippets", 0, 1)
endif
