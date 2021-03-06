set nocompatible " This has to be the first thing

set secure " Shell commands not avaible in .vimrc
set exrc " Vim can load local .vimrc

" ============================================================
" |                                                          |
" |                      PlugImport                          |
" |                                                          |
" ============================================================

call plug#begin('~/.vim/plugged')

" BASE STUFF

Plug 'scrooloose/nerdtree' " NERDtree | must have
Plug 'easymotion/vim-easymotion' " Easymotion | jump everywhere in document
Plug 'ctrlpvim/ctrlp.vim' " CtrlP | Really comfort-ish fuzzy finder
Plug 'ryanoasis/vim-devicons' " Devicons | Pretty icons, 'cause I need them
Plug 'yggdroot/indentline' " Indentline | Show indentlines
Plug 'tpope/vim-surround' " Surround | Parenthesis used as text object
Plug 'cohama/lexima.vim' " Auto-complete parenthesis
Plug 'mhinz/vim-startify' " Startify | pretty starting CReature with usefull quotes :)
Plug 'scrooloose/nerdcommenter' " NERDcommenter | feels good to comment stuff
Plug 'sjl/gundo.vim' " Gundo | smarter fork of vim undo
Plug 'jlanzarotta/bufexplorer'

" LANGUAGE SPECIFIC

Plug 'plytophogy/vim-virtualenv'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'


" GIT INTERACTIONS
Plug 'gisphm/vim-gitignore' " Gitignore | ignore 'em !
Plug 'Xuyuanp/nerdtree-git-plugin' " NERDtree-git | git interactions to NERDtree

call plug#end()
" ============================================================
" |                                                          |
" |                      PlugImport END                      |
" |                                                          |
" ============================================================

" ============================================================
" |                                                          |
" |                   VIM-base-configuration                 |
" |                                                          |
" ============================================================


source ~/.vim/config/parts/general.vim


source ~/.vim/config/parts/autocommands.vim


source ~/.vim/config/parts/gui.vim


source ~/.vim/config/parts/highlights.vim


source ~/.vim/config/parts/searching.vim


source ~/.vim/config/parts/functions.vim


source ~/.vim/config/parts/mappings.vim


" ============================================================
" |                                                          |
" |                    VIM-base-conf END                     |
" |                                                          |
" ============================================================

" ============================================================
" |                                                          |
" |                   Plugin-specific-conf                   |
" |                                                          |
" ============================================================


source ~/.vim/config/parts/plugins/nerdtree.vim


source ~/.vim/config/parts/plugins/easymotion.vim


source ~/.vim/config/parts/plugins/lexima.vim


source ~/.vim/config/parts/plugins/indentline.vim


source ~/.vim/config/parts/plugins/ctrlp.vim


source ~/.vim/config/parts/plugins/gundo.vim


source ~/.vim/config/parts/plugins/virtualenv.vim


source ~/.vim/config/parts/plugins/lsp_general.vim


source ~/.vim/config/parts/plugins/lsp_rust.vim


source ~/.vim/config/parts/plugins/asynccomplete.vim


" ============================================================
" |                                                          |
" |               Plugin-specific-conf END                   |
" |                                                          |
" ============================================================
