借助python将vim中选中的内容发送到本地主机, 由rfb_localhost.pyw接收并根据消息id处理
	msgid=1: 将内容写到本地主机的剪切板中 

相关文件: 
	.vim/python/dlvi/rfb.py
		vim的插件
		在normal模式下 :py DLVI_ClipBoard_NMode()  # 将当前/最近选中的文本发送到本地主机的剪切板中
		在visual模式下 :py DLVI_ClipBoard_VMode()  # 将当前选中的文本发送到本地主机的剪切板中
	rfb_localhost.pyw
		需要在本地主机运行, 接收处理数据


安全性:
	需要开启端口, 会直接修改本地剪切板内容. 并没有做认证. 所以不安全

配置:
	let g:DLVI_LocalIp	本地主机ip地址. 默认$SSH_CONNECTION (如果ssh多级跳转, 则$SSH_CONNECTION的值并非本地主机ip)
	let g:DLVI_LocalPort 本地主机监听端口. 默认为21032
