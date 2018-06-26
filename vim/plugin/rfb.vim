" DLFB: remote feed back
"
"
"
"let g:RFB_LocalIp=$SSH_CONNECTION
"let g:RFB_LocalPort=21032

function DLFB_Init()
	if has('python')
		execute ":pyf ~/.vim/python/dlvi/rfb.py"
	elseif has('python3')
		execute ":py3f ~/.vim/python/dlvi/rfb.py"
	endif
		
	if !exists("g:RFB_LocalIp")
		let l:localip=$SSH_CONNECTION
		let l:idx=stridx(localip, ' ')
		let l:ip=strpart(localip, 0, idx)
		let g:DLFB_LocalIp=l:ip
	endif
	if !exists("g:RFB_LocalPort")
		let g:DLFB_LocalPort=21032
	endif
endfunction

if has('python') || has('python3')
	call DLFB_Init()
endif
