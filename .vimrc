" http://c7.se/switching-to-vundle/
" https://github.com/carlhuda/janus
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'easymotion/vim-easymotion'
Bundle 'jeetsukumaran/vim-buffergator'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/nerdcommenter'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'jiangmiao/auto-pairs'
Bundle 'tpope/vim-surround'
Bundle 'mattn/emmet-vim'
Bundle 'pangloss/vim-javascript'
Bundle 'thoughtbot/vim-rspec'
Bundle 'tpope/vim-rvm'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-markdown'
Bundle 'jtratner/vim-flavored-markdown'
Bundle 'chrishunt/color-schemes'
Bundle 'alessandroYorba/Sierra'
Bundle 'nanotech/jellybeans.vim'
Bundle 'antlypls/vim-colors-codeschool'
Bundle 'altercation/solarized'

filetype plugin  on

syntax on
"colorscheme jellybeans
"colorscheme codeschool

" Basic config
set number
set expandtab
set tabstop=2
set shiftwidth=2
set hlsearch
set ignorecase
set smartcase
set nowrap
set mouse=a

let mapleader = ","

" Nerdtree
noremap <c-o> :NERDTreeToggle<CR>
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

" Ctag
noremap <leader>[ <c-t>
noremap <leader>] <c-]>

" Buffer shortcuts
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>n :bn<CR>

" Windows resize
if bufwinnr(1)
  map _ <c-w><<c-w><
  map + <c-w>><c-w>>
  map - <c-w>-<c-w>-
  map = <c-w>+<c-w>+
endif

" Syntastic
" let g:syntastic_python_checkers = ['python']
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" Fugitive
noremap <leader>gb :Gblame<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gd :Gdiff<CR>
noremap <leader>gl :Glog<CR>
noremap <leader>gc :Gcommit<CR>
noremap <leader>gp :Git push<CR>

"set rtp+=~/.fzf
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Show tab with file name
let &titlestring = @%
set title

" Set sliver searcher as base for grep
if executable('ag')
  " Note we extract the column as well as the file and line number
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c%m

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
  nnoremap \ :Ag<SPACE>
endif

" Set rspec shortcuts
map <Leader>c :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "compiler rspec| set makeprg=spring | !spring rspec {spec}"
let g:rspec_runner = "os_x_iterm2"

" Split current tmux window, running `bundle open` on the 
" argument-specified Gem name. Auto-completes from Gemfile.lock.
command! -nargs=* -complete=custom,ListGems BundleOpen silent execute "!tmux splitw 'bundle open <args>'"

fun ListGems(A,L,P)
  return system("grep -s '^ ' Gemfile.lock | sed 's/^ *//' | cut -d ' '  -f1 | sed 's/!//' | sort | uniq")
endfun
