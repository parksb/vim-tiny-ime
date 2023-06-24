" Prevent it from being loaded twice
if exists('g:loaded_tiny_ime')
  finish
endif
let g:loaded_tiny_ime = 1

if !exists('g:tiny_ime_default')
  let g:tiny_ime_default = 'ABC'
endif
let g:tiny_ime_last = g:tiny_ime_default

" Verify that the build is complete
let s:tiny_ime_dir = expand('<sfile>:p:h:h')
if !executable(s:tiny_ime_dir.'/set-ime') || !executable(s:tiny_ime_dir.'/get-ime')
  echo 'vim-tiny-ime: You have to run the following command to complete install of vim-tiny-ime.'
  echo ' '
  echo '    $ '.s:tiny_ime_dir.'/build'
  echo ' '
  finish
endif

" Register 'set-ime' and 'get-ime' to the autocommands
augroup tiny_ime
  autocmd!
  autocmd InsertEnter * silent! call TinyIMEOnInsertEnter()
  autocmd InsertLeave * silent! call TinyIMEOnInsertLeave()
augroup END

function TinyIMEOnInsertEnter()
  execute '!'.s:tiny_ime_dir.'/set-ime "'.g:tiny_ime_last.'"'
endfunction

function TinyIMEOnInsertLeave()
  let g:tiny_ime_last = trim(system(s:tiny_ime_dir.'/get-ime'))
  if empty(g:tiny_ime_last)
    let g:tiny_ime_last = g:tiny_ime_default
  endif
  execute '!'.s:tiny_ime_dir.'/set-ime "'.g:tiny_ime_default.'"'
endfunction
