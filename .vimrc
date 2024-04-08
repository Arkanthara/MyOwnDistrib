" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Call the .vim/plug.vim file
if filereadable(expand("~/.vim/plug.vim"))
        source ~/.vim/plug.vim
endif

"let g:lightline = {'colorscheme': 'catppuccin_frappe'}

" Turn syntax highlighting on.
syntax on


let g:mapleader = " "

"filetype plugin indent on
let g:dracula_colorterm = 0
colorscheme dracula

let g:md_args = ""

command! -nargs=* ChangePandoc call Change_pandoc_type(<f-args>)

function! Change_pandoc_type(...)
        let g:md_args = ""
        let indice_1 = index(a:000, 'u')
        let indice_2 = index(a:000, 'd')
        let indice_3 = index(a:000, 't')
        let indice_4 = index(a:000, 'beamer')
        let indice_5 = index(a:000, 'n')
        if indice_1 >= 0
                let g:md_args = g:md_args . " --filter pandoc-plantuml "
        endif
        if indice_2 >= 0
                let g:md_args = g:md_args . " --defaults /home/darcy/.config/pandoc/dracula.yaml "
        endif
        if indice_3 >= 0
                let g:md_args = g:md_args . " --toc "
        endif
        if indice_4 >= 0
                let g:md_args = g:md_args . " -t beamer "
        endif
        if indice_5 >= 0
                let g:md_args = g:md_args . " -N "
        endif

endfunction


