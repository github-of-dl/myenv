" DLVI: dl vi plugin
"
"
"

""""""""""
" variables
""""""""""
"g:DLVI_LocalIp=$SSH_CONNECTION
"g:DLVI_LocalPort=21032
"g:DLVI_Auther=$USER
"g:DLVI_Mail='yourmail@xx.com'



" init default variable
if !exists("g:DLVI_Auther")
	let g:DLVI_Auther=$USER
endif
if !exists("g:DLVI_Mail")
	let g:DLVI_Mail='yourmail@xx.com'
endif
if !exists("g:DLVI_LocalIp")
	let localip=$SSH_CONNECTION
	let idx=stridx(localip, ' ')
	let ip=strpart(localip, 0, idx)
	let g:DLVI_LocalIp=ip
endif
if !exists("g:DLVI_LocalPort")
	let g:DLVI_LocalPort=21032
endif


" load python
if has('python')
	execute ":pyf ~/.vim/python/dlvi/interface.py"
elseif has('python3')
	execute ":py3f ~/.vim/python/dlvi/interface.py"
else
	"
endif

""""""""""""cscope""""""""""""""
if has('cscope')
    set cscopetag
    set nocsverb
    set csto=1

	" search from current directory of the 'cscope.out' upwards recursively
	" if 'cscope.out' is found, add it to cscope database
	let cscope_database_file_name='cscope.out'
	let cscope_file = findfile(cscope_database_file_name, ".;")
	if cscope_file != '' || cscope_file != cscope_database_file_name
		if filereadable(cscope_file)
			let cscope_pre=matchstr(cscope_file, ".*/")
			exe 'cs add' cscope_file cscope_pre
		endif
	endif

	" 0 or s: Find this C symbol
	" 1 or g: Find this definition
	" 2 or d: Find functions called by this function
	" 3 or c: Find functions calling this function
	" 4 or t: Find this text string
	" 6 or e: Find this egrep pattern
	" 7 or f: Find this file
	" 8 or i: Find files #including this file
	nmap <C-\>s :scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>g :scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>c :scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-\>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>
endif

" pwd=servercode/scene_service
" change directory to ../build/scene_service && make current file 
function! DLVI_mkCurFile()
	let filename=expand('%:t')
	let filenameobj=filename . ".o"
	let dir_head_name=expand('%:p:h:h')
	let dir_base_name=expand('%:p:h:t')
	"echo dir_head_name
	"echo dir_base_name
	let dir=dir_head_name . "/build/" . dir_base_name
	
	let cmd="make -C " . dir . " " . filenameobj
	exe cmd
endfunction
