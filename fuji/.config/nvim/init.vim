" .vimrc/init.vim
"
" github.com/notchum

" Turn on syntax highlighting
syntax on
syntax enable

set nocompatible   " Don't try to be vi compatible
set modelines=0    " Security
set number         " Show line numbers
set relativenumber " Show relative line numbers
set ruler          " Show file stats
set visualbell     " Blink cursor on error instead of beeping (grr)
set encoding=utf-8 " Encoding
set noshowmode     " Show mode in last line
set hidden         " Allow hidden buffers
set hlsearch       " Highlight search results
set incsearch      " Incremental search
set ignorecase     " Not case sensitive
set smartcase      " For case search w/ignorecase
set showmatch      "
set ttyfast        " Rendering
set laststatus=2   " Status bar
set mouse=a        " Use mouse
set scrolloff=3    " Scroll offset
set wrap           " Whitespace
set textwidth=55
set backspace=indent,eol,start
set formatoptions=tcqrn1
set tabstop=3
set shiftwidth=3
set softtabstop=3
set expandtab

" Load plugins here
filetype off " Helps force plugins to load correctly when it is turned back on below
" call plug#begin()
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/plugged')

Plug 'rose-pine/neovim'             " colorscheme
Plug 'itchyny/lightline.vim'        " statusline
Plug 'preservim/nerdtree'           " fs explorer
Plug 'preservim/nerdcommenter'      " comments
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'jiangmiao/auto-pairs'      " auto parens, brackets, quotes
Plug 'Yggdroot/indentLine'       " show line indents
Plug 'airblade/vim-gitgutter'    " show git diffs
Plug 'Chiel92/vim-autoformat'    " format code
Plug 'vim-jp/vim-cpp'            " cpp syntax
Plug 'vim-python/python-syntax'  " python syntax
Plug 'plasticboy/vim-markdown'   " md syntax
Plug 'elzr/vim-json'             " json syntax
Plug 'sheerun/vim-polyglot'      " improved syntax highlighting
Plug 'ryanoasis/vim-devicons'    " icons
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
filetype plugin indent on " For plugins to load correctly

" colorscheme
colorscheme rose-pine
if has("termguicolors")
   set termguicolors
endif
hi Normal guibg=NONE ctermbg=NONE

" Plugin configurations
let g:lightline = { 'colorscheme': 'rose-pine' }
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:indentLine_char = '⎸'
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderPatternMatching = 1
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▎'
let g:gitgutter_sign_added = '▎'
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let mapleader = " " " set leader key

autocmd BufNewFile,BufRead *.tpp set syntax=cpp " cpp syntax highlighting for tpp files

set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" don't pass messages to |ins-completion-menu|.
set shortmess+=c

" visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬,space:.
map <leader>l :set list!<CR> " Toggle tabs and EOL

" searching
nnoremap / /\v
vnoremap / /\v

" de-tabbing
nnoremap <S-Tab> <<gv
inoremap <S-Tab> <C-d>gv
vnoremap <S-Tab> <gv

" tabbing
nnoremap <Tab> >>gv
vnoremap <Tab> >gv

" formatting
noremap <F3> :Autoformat<CR>

" swapping splits
nnoremap <A-w><A-w> <C-w><C-w>
tnoremap <A-w><A-w> <C-w><C-w>
vnoremap <A-w><A-w> <C-w><C-w>

" nerdtree mapping
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
map <C-_> <leader>c<space>

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

" Map <tab> for trigger completion, completion confirm, snippet expand and jump
inoremap <silent><expr> <TAB>
         \ pumvisible() ? coc#_select_confirm() :
         \ coc#expandableOrJumpable() ?
         \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
         \ <SID>check_back_space() ? "\<TAB>" :
         \ coc#refresh()

function! s:check_back_space() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
   if win_gotoid(g:term_win)
      hide
   else
      botright new
      exec "resize " . a:height
      try
         exec "buffer " . g:term_buf
      catch
         call termopen($SHELL, {"detach": 0})
         let g:term_buf = bufnr("")
         set nonumber
         set norelativenumber
         set signcolumn=no
      endtry
      startinsert!
      let g:term_win = win_getid()
   endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>
