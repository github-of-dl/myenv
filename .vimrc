set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

set number
set ignorecase
set autoindent

set textwidth=0		" no wrap line automatically
set wrapmargin=0	" no wrap
"set wrap
set formatoptions=l

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
"nmap <F11> :!update_cscope<CR><CR>

" taglist
nnoremap <silent> <F11> :TlistOpen<CR>

nmap <space> :

"""""""""""""""""""""""""map command (plugin: a.vim)""""""""""""""""""""""""""
let g:alternateRelativeFiles=1
:cabbrev av <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'AV' : 'av')<CR>
:cabbrev as <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'AS' : 'as')<CR>
:cabbrev a <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'A' : 'a')<CR>
:cabbrev at <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'AT' : 'at')<CR>

"""""""""""""""""""""""""ALT shortcuts"""""""""""""""""""""""""
" in visual mode: press <alt-v> to write selected text into clipboard
vmap v :w! ~/.clipboard <CR>							
" in normal mode: when press *, write current word into clipboard
" nmap * *``:call DClipboard_cursor()<CR><CR>
nmap * *``:call DClipboard_search()<CR><CR>


"""""""""""""""dlvi""""""""""""""""
let g:DLVI_Auther = 'DL'
let g:DLVI_Mail = 'donglei_program@126.com'
noremap c :py DLVI_InsertComment()<CR>
noremap i :py DLVI_ImplementMethod()<CR>
noremap m :py DLVI_GetMyReadmine()<CR>
vmap y :py DLVI_ClipBoard_VMode()<CR>	
nmap y :py DLVI_ClipBoard_NMode()<CR>
vmap = :py DLVI_Vertical_Align('<','>',' ', '//')<CR>
"""""""""""""""""""""""""""""""""""
