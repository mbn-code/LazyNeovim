#!/bin/bash

# Install Neovim using Homebrew
brew install neovim

# Create Neovim config directory if it doesn't exist
mkdir -p ~/.config/nvim

# Create and edit the Neovim init.vim file
cat > ~/.config/nvim/init.vim << 'EOF'
" Use vim-plug to manage plugins
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'               " File explorer
Plug 'vim-airline/vim-airline'          " Status bar
Plug 'vim-airline/vim-airline-themes'   " Airline themes
Plug 'tpope/vim-fugitive'                " Git integration
Plug 'dense-analysis/ale'                " Linting and syntax checking
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Language server protocol (LSP) support
Plug 'scrooloose/nerdcommenter'         " Easy commenting
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Auto-completion
Plug 'SirVer/ultisnips'                 " Snippet manager
Plug 'honza/vim-snippets'               " Snippets collection
Plug 'ludovicchabant/vim-gutentags'     " Automatic tags management
Plug 'vim-scripts/Conque-Shell'         " Terminal emulator
call plug#end()

" Plugin settings
" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Airline
let g:airline_theme='gruvbox'

" ALE
let g:ale_linters = {
  \   'javascript': ['eslint'],
  \}
let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \}

" COC
" You may want to configure specific languages here, e.g., for Python:
" autocmd FileType python setl lsp

" Enable mouse support
set mouse=a

" Enable syntax highlighting
syntax on

" Set tab width to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Enable line numbers
set number

" Highlight current line
set cursorline

" Show matching parentheses
set showmatch

" Highlight search results
set hlsearch

" Ignore case when searching
set ignorecase

" Smart case when searching
set smartcase

" Enable incremental search
set incsearch

" Enable undo history
set undofile

" Use UTF-8 encoding
set encoding=utf-8
set fileencoding=utf-8

" Set file format to unix
set ff=unix

" Auto-indent
filetype plugin indent on

" NERDTree settings
autocmd vimenter * if !argc() | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Auto-completion settings
let g:deoplete#enable_at_startup = 1

" Snippet settings
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Automatic tags generation settings
let g:gutentags_project_root = ['.git', '.svn', '.hg', '.project', 'Makefile']
let g:gutentags_cache_dir = '~/.cache/tags/'
let g:gutentags_ctags_executable = '/usr/local/bin/ctags'
let g:gutentags_ctags_extra_args = ['--tag-relative', '--fields=+n', '--sort=foldcase']

" NERDCommenter settings
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = {
  \ 'c': { 'left': '/**', 'right': '*/' }
  \}

" ConqueShell settings
autocmd VimEnter * ConqueTermSplit bash
map <C-t> :ConqueTermSplit bash<CR>

EOF

# Install dependencies
echo "Installing dependencies..."
nvim +PlugInstall --sync telescope.nvim fzf-lua

# Install CopilotChat.nvim
echo "Installing CopilotChat.nvim..."
curl -fLo ~/.local/share/nvim/site/pack/packer/start/CopilotChat.nvim https://github.com/wellle/CopilotChat.nvim/archive/refs/heads/main.zip && unzip -qq ~/.local/share/nvim/site/pack/packer/start/CopilotChat.nvim

# Restart Neovim for changes to take effect
echo "Restarting Neovim..."
nvim --headless -c quitall

echo "CopilotChat.nvim and its dependencies are installed!"

# (Optional) Open nvim configuration file
echo "Do you want to open your nvim configuration file to configure CopilotChat? (y/n)"
read -r response

if [[ "$response" =~ ^([Yy]) ]]; then
  echo "Opening nvim configuration..."
  nvim ~/.config/nvim/init.vim
fi


echo "Neovim setup complete!"

