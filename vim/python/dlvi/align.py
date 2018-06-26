#import vim
import os
import re
import time
import sys

# split @s with @sep and remain sep
def split_remain_sep(s, sep):
	parts=None
	if(sep==' '):
		parts=s.split();
	else:
		parts=s.split(sep);
		tmp=[]
		for i in range(0, len(parts)):
			part=parts[i]
			tmp.append(part);
			if(i+1<len(parts)):
				tmp.append(sep);
		parts=tmp;
	return parts;

def split_str_with_multi_sep(text, seps):
	parts=[text]
	for i in range(0, len(seps)):
		sep = seps[i];
		tmp=[];
		for part in parts:
			tmp.extend( split_remain_sep(part, sep) );
		parts=tmp;

	# remove empty parts
	tmp=[]
	for part in parts:
		if(len(part)!=0):
			tmp.append(part);
	return tmp

def get_prefix_space(lines):
	max_prefix_len=0
	for line in lines:
		exline=line.expandtabs(4);
		prefix_len=0;
		for c in exline:
			if(c.isspace()):
				prefix_len=prefix_len+1
			else:
				break;
		#print(prefix_len)
		if(max_prefix_len<prefix_len):
			max_prefix_len=prefix_len
	s=''
	for i in range(0,max_prefix_len):
		s=s+' '
	#print(max_prefix_len);
	return s

def vertical_align(lines, seps):
	prefix = get_prefix_space(lines);

	split_lines=[]
	part_len_array=[]
	for line in lines:
		parts=split_str_with_multi_sep(line, seps);
		for i in range(len(part_len_array), len(parts)):
			part_len_array.append(0);
		for i in range(0, len(parts)):
			part=parts[i]
			if(part_len_array[i] < len(part)):
				part_len_array[i]=len(part);
		split_lines.append(parts);
	
	#for s in split_lines:
	#	print(s);
	#for l in part_len_array:
	#	print(l);
	
			
	outlines=[]
	for line in split_lines:
		outline=prefix
		for i in range(0, len(line)):
			part=line[i];
			part_max_len=part_len_array[i];
			if(i!=0):
				outline=outline+' ';
			outline=outline + part;
			for j in range(len(part), part_max_len):
				outline=outline+' ';
		outlines.append(outline);
	return outlines;
		
if __name__ == '__main__':
	texts1=[
		"hello world = 10",
		"information u = 20",
		"make    table   = 3000;",
		"root@localhost ab = 3"
	]
	texts2=[	
				"::common::CObjectPool< ::common::CSession, OBJTYPE_SESSION > session_pool_;",
				"::common::CObjectPool < CSceneInstance, OBJTYPE_SCENE > scene_pool_;",
	];
	texts3=[
	    "optional  int32_tfgegdegdfajldjflajsdfja ret          = 1;   ",
		"optional int32 buytype                           = 2;   ",
		"optional int32 numtype    =    3;",
		"repeated PBPropsInfo  recv_awards  = 4;  "
	]

	#for t in texts1:
	#	split_str_with_multi_sep(t, ['>','<',' ']);
	#for t in texts2:
	#	parts=split_str_with_multi_sep(t, [' ','<']);
	#	for part in parts:
	#		print('>>', part);
	#for t in texts3:
	#	split_str_with_multi_sep(t, ['>','<',' ']);

	#outlines=vertical_align(texts1, ['>','<',' ']);
	#for line in outlines:
	#	print(line);
	outlines=vertical_align(texts2, [' ','<']);
	for line in outlines:
		print(line);
	#outlines=vertical_align(texts3, ['>','<',' ']);
	#for line in outlines:
	#	print(line);
	#
