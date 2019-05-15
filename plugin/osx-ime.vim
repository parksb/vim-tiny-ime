" This file is part of vim-osx-ime.
"
" vim-osx-ime is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.

" vim-osx-ime is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.

" You should have received a copy of the GNU General Public License
" along with Foobar.  If not, see <http://www.gnu.org/licenses/>.

if exists('g:loaded_osxime')
    finish
endif
let g:loaded_osxime = 1

if !exists('g:osxime_normal_ime')
    let g:osxime_normal_ime = 'U.S.'
endif

if !exists('g:osxime_cjk_ime')
    let g:osxime_cjk_ime= 'Squirrel'
endif

if !exists('g:osxime_cjk_default_english')
    let g:osxime_cjk_default_english = (g:osxime_cjk_ime == "Squirrel")
endif

if !exists('g:osxime_auto_detect')
    let g:osxime_auto_detect = 1
endif

if !exists('g:osxime_binary_dir')
    let g:osxime_binary_dir = expand('<sfile>:p:h:h')
endif
let s:osxime_binary = g:osxime_binary_dir . "/input-method"

if findfile('input-method', g:osxime_binary_dir) == ""
    echo 'vim-osxime: ' . s:osxime_binary . ' is not found'
    echo 'vim-osxime: Forgotten to run make?'
    finish
endif

function s:switch_normal_ime()
    call s:switch_ime(g:osxime_normal_ime)
endfunction

function s:switch_cjk_ime(cjk_mode)
    call s:switch_normal_ime()
    " Press Command-Space
    silent !echo "tell application \"System Events\"\n
                 \    keystroke \" \" using {command down}\n
                 \end tell" | osascript
    " If default english but we want cjk mode, press shift.
    " If default cjk but we want english mode, press shift.
    if a:cjk_mode == g:osxime_cjk_default_english
        call s:press_shift()
    endif
endfunction

function s:switch_ime(ime)
    execute "silent !" . s:osxime_binary . " '" . a:ime . "' > /dev/null"
endfunction

function s:press_shift()
    silent !echo "tell application \"System Events\"\n
                 \    key down shift\n
                 \    key up shift\n
                 \end tell" | osascript
endfunction

function s:insert_entered()
    if g:osxime_auto_detect
        let l:char = getline('.')[col('.') - 2]
        let l:cjk_mode = l:char >= "\x80"
    else
        let l:cjk_mode = 1
    endif
    call s:switch_cjk_ime(l:cjk_mode)
endfunction

function s:insert_leave()
    call s:switch_normal_ime()
endfunction

autocmd InsertEnter * :call s:insert_entered()
autocmd InsertLeave * :call s:insert_leave()
