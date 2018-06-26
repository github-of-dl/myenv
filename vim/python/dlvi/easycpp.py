# make it easier to code cpp with vim
#
#
import vim
import os
import re
import time

from dlvi import utility

######internal methods#######
def is_prefixed_with_comment(line):
	return re.match('\s*//', line) or re.match('\s*/\*', line);

def is_class(line):
	'''
		return name of class if yes. None if no.
	'''
	ret = re.match('\s*class\s+(\w+)', line);
	if(ret):
		return ret.groups()[0];
	else:
		return None;
def is_namespace(line):
	'''
		return name of namespace if yes. None if no.
	'''
	ret = re.match('\s*namespace\s+(\w+)', line);
	if(ret):
		return ret.groups()[0];
	else:
		return None;

def is_empty_header_file(b, w):
	return (len(b)==1) and len(b[0])==0 and utility.get_filename_from_buffer(b).endswith('.h');

def is_function(line):
	line = line.strip();
	line = line.replace('virtual', '');
	line = line.replace('static', '');
	line = line.replace('=0', '');
	line = line.replace('const;', ';');
	if(not re.match('.*\w+\s*\(.*\)\s*;', line)):
		return None;
	funcname = re.match('.*\s+(?:\*){0,1}(\w+)\s*\(.*\).*', line).groups()[0];
	args = re.findall('(\w+)[,\)]', line);
	ret = [funcname];
	ret.extend(args);
	return ret;

def remove_comment(b):
	'''
		replace comment with ' '
	'''
	comment_type=0; # 0: not comment, 1: line comment, 2: block comment
	in_quote=False;
	for row in range(0, len(b)):
		pre_ch = ' ';
		line = []
		for ch in b[row]: 
			line.append(ch);
		if(comment_type==1):
			comment_type=0;
		for col in range(0, len(line)):
			if(comment_type==0):
				if(in_quote):
					if(pre_ch!='\\' and line[col]=='"'):
						in_quote=False;
						pre_ch=' ';
					else:
						pre_ch=line[col];
				else:
					if(pre_ch!='\\' and line[col]=='"'):
						in_quote=True;
						pre_ch=' ';
					elif(pre_ch=='/' and line[col]=='/'):
						comment_type=1;
						if(col>0): line[col-1]=' ';
						line[col]=' ';
						pre_ch=' ';
					elif(pre_ch=='/' and line[col]=='*'):
						comment_type=2;
						if(col>0): line[col-1]=' ';
						line[col]=' ';
						pre_ch=' ';
					else:
						pre_ch=line[col];
			elif(comment_type==1):
				line[col]=' ';
				pre_ch=line[col];
			else:
				if(pre_ch == '*' and line[col] == '/'):
					comment_type = 0;
					line[col]=' ';
					pre_ch = ' ';
				else:
					pre_ch = line[col];
				line[col] = ' ';

def get_namespace(b, currow):
	ns_list=[]
	braces=0; 
	pre_braces=0;
	for row in range(currow-1, -1, -1):
		line=b[row];
		for col in range(len(b[row])-1, -1, -1):
			ch=b[row][col];
			if(ch=='}'):
				braces=braces+1;
			elif(ch=='{'):
				braces=braces-1;
		if(braces<pre_braces):
			if(is_class(line)):
				name = is_class(line);
				ns_list.insert(0, name);
				pre_braces = braces;
			elif(is_namespace(line)):
				name = is_namespace(line);
				ns_list.insert(0, name);
				pre_braces = braces;
	return ns_list;

def insert_class_comment(b, row, indentstr):
	utility.insert_line(b, row, "%s/**" %(indentstr));	
	utility.insert_line(b, row+1, "%s*" %(indentstr));	
	utility.insert_line(b, row+2, "%s*/" %(indentstr));	

def insert_file_comment(b, filename, indentstr):
	utility.insert_line(b, 0, "%s/**" %(indentstr));	
	utility.insert_line(b, 1, "%s* @%-10s %s" %(indentstr, "filename", filename));	
	utility.insert_line(b, 2, "%s* @%-10s %s" %(indentstr, "auther", vim.vars['DLVI_Auther']));	
	utility.insert_line(b, 3, "%s* @%-10s %s" %(indentstr, "date", time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime())));	
	utility.insert_line(b, 4, "%s* @%-10s %s" %(indentstr, "mail", vim.vars['DLVI_Mail']));	
	utility.insert_line(b, 5, "%s*/" %(indentstr));	

def insert_func_comment(b, row, indentstr):
	cur_line = b[row];
	funcargs = is_function(cur_line);
	utility.insert_line(b, row, "%s/**" %(indentstr));	
	i=1;
	for i in range(1,len(funcargs)):
		utility.insert_line(b, row+i, "%s* @%s" %(indentstr, funcargs[i]));	
	utility.insert_line(b, row+len(funcargs), "%s* @return" %(indentstr));
	utility.insert_line(b, row+len(funcargs)+1, "%s*/" %(indentstr));	

def insert_ifndef_comment(b, w, filename):
	str = filename.upper().replace('.','_');
	utility.insert_line(b, 0, "#ifndef %s" %(str));
	utility.insert_line(b, 1, "#define %s" %(str));
	utility.insert_line(b, 2, "");
	utility.insert_line(b, 3, "");
	w.cursor= (3, 0);	
	utility.set_line(b, 4, "#endif //%s" %(str));

def insert_implement(b, content, row, indentstr):
	funcargs = is_function(content);
	func_name=funcargs[0];
	ns_list = get_namespace(b, row);
	ns_list.append('');
	content = content.replace(func_name, '::'.join(ns_list) + func_name);
	content = content.replace(';','');
	utility.insert_line(b, row, content);
	utility.insert_line(b, row+1, '%s{' %indentstr);
	utility.insert_line(b, row+2, '%s}' %indentstr);
