文件: 
	export PROJECT_FILE=project.xml

	所在路径为一个项目的根目录
	更新ctags, cscope需要


c/psysconf:
	打印系统中的一些参数信息


session_mgr:
	为一组ssh连接设置一个相同的tag. 该tag可以用来初始化工作环境. 例如登录后, 自动切换到某个目录

	XShell: 使用login-script执行 "session_mgr tag_of_current_session" 来为新的session设置tag.
	使用init_env_according_to_session_tag来根据
