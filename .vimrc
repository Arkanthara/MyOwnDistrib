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

"filetype plugin indent on
let g:dracula_colorterm = 0
colorscheme dracula
