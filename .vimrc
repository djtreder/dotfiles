"General {{{
set nocompatible
filetype plugin indent on
syntax enable
set showcmd
set expandtab
set shiftwidth=2
set softtabstop=2
set autochdir
set hidden
set directory=$HOME/.vim/.backups//
"}}}
"Vundle setup {{{
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"General {{{
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'alkino/ods.vim'
"}}}
"Ruby {{{
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'ngmy/vim-rubocop'
"}}}
"Colors {{{
Plugin 'tpope/vim-vividchalk'
Plugin 'C64.vim'
Plugin 'chriskempson/base16-vim'
"}}}
"Markdown {{{
Plugin 'tpope/vim-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'nelstrom/vim-markdown-folding'
"}}}
"Docker {{{
Plugin 'docker/docker', {'rtp': 'contrib/syntax/vim/'}
"}}}
"Julia {{{
Plugin 'JuliaLang/julia-vim'
"}}}
"Lua {{{
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-lua-ftplugin'
"}}}
"Elixir {{{
Plugin 'elixir-lang/vim-elixir'
"}}}
call vundle#end()
filetype plugin indent on
"}}}
"Theme settings {{{
set background=dark
"}}}
"Number settings {{{
set number
set relativenumber
set numberwidth=4
"}}}
"Leader settings {{{
let mapleader="-"
let maplocalleader=","
"}}}
"Vimscript file settings {{{
nnoremap <leader>ee :tabe $MYVIMRC<cr>
augroup filetype_vim
	autocmd!
	autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>
	autocmd FileType vim nnoremap <buffer> <localleader>p oPlugin ''<esc>i
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType vim setlocal foldlevelstart=0
	autocmd bufwritepost .vimrc source $MYVIMRC
augroup END
" }}}
" Markdown file settings {{{
augroup filetype_markdown
	autocmd!
	autocmd BufNewFile,BufReadPost *.md,*.markdown set filetype=ghmarkdown.markdown
        autocmd FileType markdown setlocal textwidth=80
augroup END
" }}}
" Ruby file settings {{{
augroup filetype_ruby
	autocmd!
	autocmd FileType ruby setlocal expandtab
	autocmd FileType ruby setlocal shiftwidth=2
	autocmd FileType ruby setlocal softtabstop=2
augroup END
" }}}
" Sh file settings {{{
augroup filetype_sh
	autocmd!
        autocmd BufRead,BufNewFile .bash_aliases set filetype=sh
	autocmd FileType sh setlocal expandtab
	autocmd FileType sh setlocal shiftwidth=4
	autocmd FileType sh setlocal softtabstop=4
	autocmd FileType sh setlocal foldmethod=marker
	autocmd FileType sh setlocal foldlevelstart=0
" }}}
" Dockerfile file settings {{{
augroup filetype_dockerfile
  autocmd!
  autocmd BufNewFile,BufReadPost *dockerfile*,*Dockerfile* set filetype=dockerfile
augroup END
" }}}
" Julia file settings {{{
augroup filetype_julia
  autocmd!
  autocmd FileType julia let g:latex_to_unicode_auto=1
" }}}
" Statusline {{{
set laststatus=2
set statusline=%f
set statusline+=\ \-\ 
set statusline+=FileType:
set statusline+=%y
"}}}
