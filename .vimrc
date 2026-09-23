set ruler

set hi=200  " history size

set showcmd " show incomplete commands

" set termguicolors to enable highlight groups
set termguicolors

set relativenumber " show relative line numbers

" no ladders on paste please
set paste

" search
set hlsearch  " highlight search results
set incsearch " incremental search (find-as-you-type)
set scs       " ignore case while searching until we use uppercase in search pattern

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" expand tabs except for makefiles and justfiles
autocmd FileType makefile set noexpandtab
autocmd FileType just set noexpandtab
set expandtab

" disable vim greeting screen
set shortmess+=I

" prevents destructive writes when file is edited in different vim instances
set autoread

set shiftwidth=2      " smart indent for 2 spaces
set ts=4              " spaces in a tab
set nu                " line numbers
set cursorline        " highlight cursor line
set cursorcolumn      " and column
set aw                " automatically write a file when leaving a modified buffer
set ar                " automatically read a file when it was modified outside of Vim
set nowarn            " do not warn when using a shell command and a buffer has changes
set laststatus=2      " always show the statusline

" recognize system clipboard
set clipboard+=unnamedplus

" leader
let mapleader = ","

" utf-8 by default
scriptencoding utf-8
set encoding=utf-8

" sudo to write
cmap w!! w !sudo sh -c "cat > %"

" switch between windows using Tab
nmap <Tab> <C-w>w

" persistent undo
" !mkdir -p ~/.vim/{undo,swap,backups}
set undodir=~/.vim/undo
set undofile

" do not pollute workdirs with swap files
" has two path separator slashes at the end. That tells Vim to create a unique
" filename for every file
set backupdir=~/.vim/backups//
set directory=~/.vim/swap//

" switch current directory to the one of the current file
" if there is an .envrc file there
autocmd BufEnter * if filereadable(expand('%:p:h') .. '/.envrc') | silent! lcd %:p:h | endif

" read direnv when switching to a buffer
autocmd BufEnter * DirenvExport

" C-x C-o completion
let g:ale_completion_enabled = 1

call plug#begin('~/.vim/plugged')

""" --- look & feel ---
Plug 'nordtheme/vim',          { 'commit': 'f13f5dfbb784deddbc1d8195f34dfd9ec73e2295' }
Plug 'itchyny/lightline.vim',  { 'commit': '6c283f8df85aa7219fa4096a6ed4ff45d48aa9e1' }
Plug 'maximbaz/lightline-ale', { 'commit': 'a861f691ac7e40b1b359bc7a147078fa1e0570ce' }

""" --- brackets ---
" autocompleting for brackets, quotes etc
Plug 'Raimondi/delimitMate',   { 'commit': 'becbd2d353a2366171852387288ebb4b33a02487' }
" add brackets to existing code
Plug 'tpope/vim-surround',     { 'commit': '3d188ed2113431cf8dac77be61b842acb64433d9' }
" rainbow brackets
Plug 'luochen1990/rainbow',    { 'commit': '76ca1a20aa42edb5c65c19029968aad4625790dc' }

""" --- save/reload ---
" reload files if changed by other process
Plug 'djoshea/vim-autoread',     { 'commit': '24061f84652d768bfb85d222c88580b3af138dab' }
Plug '907th/vim-auto-save',      { 'commit': '2e3e54ea4c0fc946c21b0a4ee4c1c295ba736ee8' }
" remember last edit position
Plug 'farmergreg/vim-lastplace', { 'commit': 'e58cb0df716d3c88605ae49db5c4741db8b48aa9' }

""" --- motion ---
" respect camel case for word motions
Plug 'chaoren/vim-wordmotion', { 'commit': '81d9bd298376ab0dc465c85d55afa4cb8d5f47a1' }
" jumping by two letters
Plug 'monkoose/vim9-stargate', { 'commit': 'b87f9e6f534de5cc261205f6fc7716ec1af28e3a' }

""" --- programming ---
" linters and fixers
Plug 'dense-analysis/ale',     { 'commit': '178fe113564d31cba304263765aeb21e7ed23a7e' }
" auto-close html tags
Plug 'alvan/vim-closetag',     { 'commit': 'd0a562f8bdb107a50595aefe53b1a690460c3822' }
Plug 'airblade/vim-gitgutter', { 'commit': '21c977e8597c468c7dc76001389b0b430d46a4b0' }

""" --- languages & formats support ---
Plug 'hashivim/vim-terraform', { 'commit': '520498fab16a3a11f2ae1b8cb65e0a1684bc317a' }
Plug 'NoahTheDuke/vim-just',   { 'commit': '6034ccf6a4682c91f90f38fae4c882068e6723fe' }
Plug 'aliou/bats.vim',         { 'commit': '19eb3c5a05aaa889647af8107a4518b3fb4a4711' }
Plug 'direnv/direnv.vim',      { 'commit': 'ab2a7e08dd630060cd81d7946739ac7442a4f269' }
Plug 'hankei6km/ale-linter-actionlint.vim', { 'commit': 'a61411c52139daac3c00a6b364bb82b6599ff615' }

""" --- misc ---
" editable files buffer
Plug 'Ashik80/VimExplorer',    { 'commit': 'ba6f84af12d4654e16418be21d4d1bc78cfbf4fd' }
" aligning text
Plug 'godlygeek/tabular',      { 'commit': '12437cd1b53488e24936ec4b091c9324cafee311' }
Plug 'tpope/vim-commentary',   { 'commit': '64a654ef4a20db1727938338310209b6a63f60c9' }
" visual bookmarks
Plug 'MattesGroeger/vim-bookmarks', { 'commit': '9cc5fa7ecc23b052bd524d07c85356c64b92aeef' }
" copying for tmux
Plug 'ojroques/vim-oscyank',   { 'commit': 'd67d76b2f19b868b70a1cf33a779d71dc092cb30' }
" fuzzy search
Plug 'ubaldot/vim-poptools',   { 'commit': 'f7d5db35a48daf9e3d443a20ce85b2a9401caf2c' }

call plug#end()

" colors
set noshowmode " no need for -- INSERT -- when lightline is used
let g:lightline = {
    \ 'colorscheme': 'one'
  \ }

" rainbow colors
let g:rainbow_conf = {
\	'guifgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\ }

" If a path to file is longer than this, it will be shortened in the status bar
let g:lightline_path_max_length = 60

function! LightlineCurrentDirectory() abort
  let l:path = expand('%:p:h')
  
  if len(l:path) > g:lightline_path_max_length
    return pathshorten(l:path, 4)
  endif
  
  return l:path
endfunction

function! ALEFixStatus()
    let l:enabled = get(g:, 'ale_fix_on_save', 0)
    return l:enabled ? 'FIX:ON' : 'FIX:OFF'
endfunction

let g:lightline.component_function = {
    \ 'cwd': 'LightlineCurrentDirectory',
    \ 'ale_fix': 'ALEFixStatus'
    \ }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \  'status': 'lightline#lsp#status',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline.active = {
        \ 'left': [ ['mode', 'paste'],
        \           [ 'readonly', 'cwd', 'filename', 'modified' ] ],
        \ 'right': [
        \            [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
        \            [ 'ale_fix' ],
        \            [ 'lineinfo' ],
	    \            [ 'percent' ],
	    \            [ 'fileformat', 'fileencoding', 'filetype'] ] }
let g:lightline#ale#indicator_ok = "\uf00c" " checkmark
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

colorscheme nord

" set syntax to sh for files with no extension
au BufNewFile,BufRead * if &syntax == '' | set syntax=sh | endif

" tftpl is terraform
augroup FiletypeGroup
  autocmd!
  au BufNewFile,BufRead *.tftpl set filetype=json
augroup END

" set syntax to sh for files with no extension
au BufNewFile,BufRead * if &syntax == '' | set syntax=sh | endif

" buffers
"set hidden
set showtabline=0                      " do not show the line with tabs/buffers on top of the screen
nnoremap <leader>q :bd<CR>             " close buffer if not modified
nnoremap <leader>. :b#<CR>             " jump to previous buffer

" autosave
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_events = ["CursorHold"] " autosave in normal mode only

" rainbow brackets
let g:rainbow_active = 1

" bookmarks
highlight BookmarkLine guifg=darkMagenta guibg=grey
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1
let g:bookmark_manage_per_buffer = 1   " autosave bookmarks
let g:bookmark_highlight_lines = 1     " highlight bookmarked line

" C-k C-j for ALE
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Go to definition for ALE
nmap <leader>df :ALEGoToDefinition<cr>

" command to toggle fixers off
command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"
nnoremap <leader>fx :ALEToggleFixer<cr>

" ALE formatters
let g:ale_linters = {
     \ 'json': ['biome'],
     \ 'make': ['checkmake'],
     \ 'python': ['flake8', 'pylint', 'ruff', 'pyright'],
     \ 'terraform': ['tflint', 'checkov'],
     \ 'sh': ['shellcheck'],
     \ 'yaml': ['yamllint'],
     \ }
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'json': ['biome'],
      \ 'html': ['dprint'],
      \ 'python': ['autopep8', 'ruff', 'black', 'isort'],
      \ 'sh': ['shfmt'],
      \ 'terraform': ['terraform'],
      \ 'yaml': ['yamlfmt'],
      \ }

let g:ale_fix_on_save = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'never'

let g:ale_python_pyright_auto_poetry = 1

let g:ale_python_auto_poetry = 1
let g:ale_python_auto_uv = 1
let g:ale_python_auto_virtualenv = 1

let g:ale_python_flake8_options = '--max-line-length=130'
let g:ale_python_pylint_options = '--max-line-length=130 --ignore-docstrings'
let g:ale_python_ruff_options = '--line-length=130 --unfixable=F841,F401'
" F841: Local variable name is assigned to but never used
" F401: Module imported but unused
let g:ale_python_autopep8_options = '--max-line-length=130'

" the whole Go package will be checked instead of only the current file
let g:ale_go_golangci_lint_package = 1

let g:ale_crystal_ameba_executable = 'ameba'

let g:ale_yaml_yamlfmt_options = '-formatter retain_line_breaks=true'

" for tcl only show errors
let g:ale_tcl_nagelfar_executable = 'nagelfar'
let g:ale_tcl_nagelfar_options = '-severity E'

let g:ale_terraform_tflint_options = '--disable-rule=terraform_required_providers --disable-rule=terraform_required_version'

" oscyank
nmap <leader>c <Plug>OSCYankOperator
nmap <leader>cc <leader>c_
vmap <leader>c <Plug>OSCYankVisual

" vimexplorer
nnoremap <C-_> :VimExplorer<CR>

" stargate
noremap <leader>ss <Cmd>call stargate#OKvim(2)<CR>

" poptools
nnoremap <leader>ff <cmd>PoptoolsFindFile<cr>
nnoremap <leader>fp <cmd>PoptoolsLastSearch<cr>
nnoremap <leader>fb <cmd>PoptoolsBuffers<cr>
nnoremap <leader>fg <cmd>PoptoolsGrep<cr>
nnoremap <leader>fd <cmd>PoptoolsFindDir<cr>
