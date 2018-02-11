文件: 
	export PROJECT_FILE=project.xml

	所在路径为一个项目的根目录
	更新ctags, cscope需要


c/psysconf:
	打印系统中的一些参数信息


session_tag:
	为一组ssh连接设置一个相同的tag. 该tag可以用来初始化工作环境. 例如登录后, 自动切换到某个目录
	XShell: 使用login-script执行 "init_env_according_to_session_tag tag_of_current_session" 来为新的session设置tag.

rfb:
	将当前vim中选中的内容发送到本地主机. 本地主机接受到数据后, 根据消息id处理
		- 将数据发送到本地主机的剪切板中


local/bin/
	fvi: 从文件名/内容中搜索关键字, 将文件用vim打开(多tab页)
	listsz: 按照大小列出当前目录下所有文件(目录)




TODO:
	project: 
		project: 显示当前项目信息 {根目录} 
		project create {projname}: 在当前目录创建名为${projname}的project
