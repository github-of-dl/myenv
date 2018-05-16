set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set hlsearch
set number
set ignorecase
set autoindent
set smartindent

set textwidth=0		" no wrap line automatically
set wrapmargin=0	" no wrap
"set wrap
set formatoptions=l

set backspace=indent,eol,start " make backspace work like in most other programs

filetype on
syntax on

"maxsize and minsize current windows horizontally
nmap - <C-W><C-_>
nmap _ <C-W>=

"change window easily
nmap , <C-W><C-W>

" move fastter
nmap J 5j
nmap K 5k

" tabpage
nmap H :tabp<CR>
nmap L :tabn<CR>

" color
colo mydarkblue

" keep N lines visible below the cursor
set scrolloff=3

" ctags | cscope
set tags=tags;/
nmap <F12> :!update_ctags<CR><CR>

nmap <space> :


" jump to the position when reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
	      \| exe "normal! g'\"" | endif
endif

"""""""""""""""""""""""""map command (plugin: a.vim)""""""""""""""""""""""""""
let g:alternateRelativeFiles=1
:cabbrev av <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'AV' : 'av')<CR>
:cabbrev as <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'AS' : 'as')<CR>
:cabbrev a <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'A' : 'a')<CR>
:cabbrev at <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'AT' : 'at')<CR>

"""""""""""""""dlvi""""""""""""""""
let g:DLVI_Auther = 'DL'
let g:DLVI_Mail = 'donglei_program@126.com'

" I HATE VIMSCRIPT
" prefix 't'
if has('python')
	noremap tc :py DLVI_InsertComment()<CR>
	noremap ti :py DLVI_ImplementMethod()<CR>
	noremap tm :py DLVI_GetMyReadmine()<CR>
	vmap ty :py DLVI_ClipBoard_VMode()<CR>	
	nmap ty :py DLVI_ClipBoard_NMode()<CR>
	vmap t= :py DLVI_Vertical_Align('<','>',' ', '//', '=')<CR>
elseif has('python3')
	noremap tc :py3 DLVI_InsertComment()<CR>
	noremap ti :py3 DLVI_ImplementMethod()<CR>
	noremap tm :py3 DLVI_GetMyReadmine()<CR>
	vmap ty :py3 DLVI_ClipBoard_VMode()<CR>	
	nmap ty :py3 DLVI_ClipBoard_NMode()<CR>
	vmap t= :py3 DLVI_Vertical_Align('<','>',' ', '//', '=')<CR>
endif
nmap ts :call DLVI_mkCurFile()<CR>
"""""""""""""""""""""""""""""""""""


""""""""""""""""""YouCompleteMe"""""""""""
let g:ycm_confirm_extra_conf=0
let g:ycm_show_diagnostics_ui=0

nmap gc :YcmCompleter GoToDeclaration<CR>
nmap gf :YcmCompleter GoToDefinition<CR>
nmap <C-]> :YcmCompleter GoTo<CR>
nmap gr :YcmCompleter GoToReferences<CR><CR>

"""""""""""""""""""""""""""""""""""""""""

