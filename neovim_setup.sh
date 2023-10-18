#!/bin/bash

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install Neovim
brew install neovim

# Create Neovim configuration directory if it doesn't exist
mkdir -p ~/.config/nvim

# Create a basic Neovim configuration file
cat <<EOF > ~/.config/nvim/init.vim
" Neovim Configuration

" Enable line numbers
set number

" Syntax Highlighting
syntax enable
set background=dark

" Plugin Manager (vim-plug)
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.config/nvim/plugged')

" YouCompleteMe
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' }

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Lightline
Plug 'itchyny/lightline.vim'

" Gruvbox Color Scheme
Plug 'morhetz/gruvbox'

" Autopairs
Plug 'jiangmiao/auto-pairs'

call plug#end()

" Configure Gruvbox Color Scheme
colorscheme gruvbox

" AutoPairs
let g:AutoPairsFlyMode = 1

" Lightline
set laststatus=2
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'component_expand': {
      \   'filename': 'lightline#buffer#filename',
      \ },
      \ 'component_type': {
      \   'readonly': 'error',
      \ }
      \ }

" Save and Quit
map <leader>q :wqa<CR>
EOF

# Install Dependencies for YouCompleteMe and coc.nvim
brew install python cmake node

# Install Plugins
nvim +PlugInstall +qall

# Install and configure Language Server Protocol (LSP) for specific languages as needed
# Example: For Python
# npm install -g pyright

echo "Neovim and plugins are installed and configured."

