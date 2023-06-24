vim-tiny-ime
========
Tiny automatic IME switcher for macOS. Switch to English IME whenever vim switchs
to normal mode.

```vim
" ~/.vimrc
Plug 'parksb/vim-tiny-ime', { 'do' : './build' }
```

## Options

If you want to change the default IME, set `g:tiny_ime_default`.

```vim
let g:tiny_ime_default = 'Colemak'
```

The default value of `g:tiny_ime_default` is `'ABC'`.

## Just one difference from simnalamburt/vim-tiny-ime

It remembers IME in the last insert mode, so you don't need to switch IME when returning from normal mode to insert mode again.
<br>

--------

*vim-tiny-ime* is primarily distributed under the terms of the [GNU General
Public License, version 3] or any later version. See [COPYRIGHT] for details.

[GNU General Public License, version 3]: LICENSE
[COPYRIGHT]: COPYRIGHT
