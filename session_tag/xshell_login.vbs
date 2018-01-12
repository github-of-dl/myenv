Sub Main
	' get session name from current xsh file
	splitret = Split(xsh.Session.Path, "\")
	index = Ubound(splitret)
	filename = splitret(index)
	
	splitret = Split(filename, ".")
	session_tag = splitret(0)
	
	' init session
	xsh.Screen.Send( "init_env_according_to_session_tag " + session_tag )
	xsh.Screen.Send(VbCr)
End Sub