import vim
import os
import re
import time
import sys

from dlvi import utility
from dlvi import rfb
from dlvi import easycpp

def DLVI_GetMyReadmine():
	w = vim.current.window
	b = vim.current.buffer;
	(row,col) = w.cursor;
	row=row-1;

	http, headers = redmine.login('http://10.10.48.243:8080/redmine/login', 'wangdonglei', 'wangdonglei');
	redmines = redmine.get_redmines(http, headers, 'http://10.10.48.243:8080/redmine/projects/g1-005/issues?query_id=192');
	for k,v in redmines.iteritems():
		utility.insert_line(b, row, "#closes #%d %s" %(k,v));	
	redmines = redmine.get_redmines(http, headers, 'http://10.10.48.243:8080/redmine/projects/g1-005/issues?query_id=195');
	for k,v in redmines.iteritems():
		utility.insert_line(b, row, "#closes #%d %s" %(k,v));	

def DLVI_InsertComment():
	w = vim.current.window
	b = vim.current.buffer;
	(row,col) = w.cursor;
	row=row-1;
	cur_line = vim.current.line
	filename = utility.get_filename_from_buffer(b);
	indentstr = utility.get_indent_str(cur_line);

	if(easycpp.is_class(cur_line)):
		easycpp.insert_class_comment(b, row, indentstr);
	elif(easycpp.is_empty_header_file(b, w)):
		easycpp.insert_ifndef_comment(b, w, filename);
	elif(easycpp.is_function(cur_line)):
		easycpp.insert_func_comment(b, row, indentstr);
	elif(row==0):
		easycpp.insert_file_comment(b, filename, indentstr);

def DLVI_ImplementMethod():
	'''
		create a implement in cpp/c file according to methods delaration
		example: 
			int Init(const char *name, int id):		# delare (header file)
			int Foo::Init(const char *name, int id) # implement (cpp file)
			{
			}
	'''
	w = vim.current.window
	b = vim.current.buffer;
	easycpp.remove_comment(b);
	(row,col) = w.cursor;
	row=row-1;
	cur_line = vim.current.line;
	filename = utility.get_filename_from_buffer(b);
	indentstr = utility.get_indent_str(cur_line);
	select_range = vim.current.range;
		
	func_lines=[]
	for idx in range(select_range.start, select_range.end+1):
		content = b[idx];
		if(easycpp.is_function(content)):
			func_lines.insert(0,content);

	for ln in func_lines:
		easycpp.insert_implement(b, ln, row, indentstr);

def DLVI_ClipBoard_VMode():
	ip = vim.vars['DLVI_LocalIp'];
	port = vim.vars['DLVI_LocalPort'];

	buf = vim.current.buffer
	text = utility.get_selected_text(buf);
	rfb.send_to_host_clipboard(ip, port, text);

def DLVI_ClipBoard_NMode():
	ip = vim.vars['DLVI_LocalIp'];
	port = vim.vars['DLVI_LocalPort'];

	text = utility.get_last_search_text();
	rfb.send_to_host_clipboard(ip,port, text);

def DLVI_Vertical_Align(*seps):
	#print(seps);
	w = vim.current.window
	b = vim.current.buffer;
	select_range = vim.current.range;
		
	original_lines=[]
	for idx in range(select_range.start, select_range.end+1):
		original_lines.append( b[idx] );

	align_lines = align.vertical_align(original_lines, seps);

	for idx in range(select_range.start, select_range.end+1):
		utility.set_line(b, idx, align_lines[idx-select_range.start]);
