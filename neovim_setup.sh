#!/bin/bash

# Define log file path
LOG_FILE="$HOME/neovim_setup.log"

# Function for logging
log() {
  echo "$1" >> "$LOG_FILE"
}

# Begin logging
log "Starting Neovim setup script..."

# Detect the operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  log "Detected macOS."
  INSTALL_CMD="brew install"
elif [[ "$OSTYPE" == "linux-gnu" || "$OSTYPE" == "linux-musl" ]]; then
  # Linux (Assuming it's using APT, you can adapt for other package managers)
  log "Detected Linux."
  INSTALL_CMD="sudo apt-get install"
else
  log "Unsupported operating system: $OSTYPE"
  exit 1
fi

# Install Neovim and log errors
log "Installing Neovim..."
$INSTALL_CMD neovim 2>> "$LOG_FILE"

# Create Neovim configuration directory if it doesn't exist
log "Creating Neovim configuration directory..."
mkdir -p ~/.config/nvim

# Create a basic Neovim configuration file
log "Creating a basic Neovim configuration file..."
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
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --ts-completer --all --clangd' }
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
log "Installing dependencies for YouCompleteMe and coc.nvim..."
if [[ "$OSTYPE" == "darwin"* ]]; then
  $INSTALL_CMD python cmake node 2>> "$LOG_FILE"
else
  $INSTALL_CMD python3 cmake nodejs build-essential 2>> "$LOG_FILE"
fi

# Check for installation errors
if [ $? -ne 0 ]; then
  log "Error during dependency installation. Please check $LOG_FILE for details."
  exit 1
fi

# Install Plugins
log "Installing Neovim plugins..."
nvim +PlugInstall +qall 2>> "$LOG_FILE"

# Check for plugin installation errors
if [ $? -ne 0 ]; then
  log "Error during plugin installation. Please check $LOG_FILE for details."
  exit 1
fi

# Additional configurations or language support can be added here

# End logging
log "Neovim and plugins are installed and configured. See $LOG_FILE for details."

