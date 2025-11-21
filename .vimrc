syntax on
inoremap <Tab> <Esc>
set backup
set linebreak
set expandtab
set shiftwidth=2
set autoindent
set smartindent
set ignorecase
set smartcase
set display+=lastline
set background=light
set incsearch
set textwidth=80
set tabpagemax=50
set ruler
colorscheme elflord
" Enable indent-based folding for YAML and Python
augroup IndentFolds
  autocmd!
  autocmd FileType yaml,python setlocal foldmethod=indent
  autocmd FileType yaml,python setlocal foldlevel=99
augroup END
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo
