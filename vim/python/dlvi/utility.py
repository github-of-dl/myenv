#
# useful methods
#
#

import vim
import os
import re
import time
import struct
import sys

def get_selected_text(buf):
	(start_row, start_col) = buf.mark('<');
	(end_row, end_col)   = buf.mark('>');
	start_row = start_row-1;
	end_row = end_row-1;

	selected_text=""
	if(start_row == end_row):
		selected_text = buf[start_row][start_col:end_col+1]
	else:
		selected_text = buf[start_row][start_col:] + "\n";
		row = start_row+1;
		while(row!=end_row):
			selected_text = selected_text + buf[row] + "\n";
			row = row+1;
		selected_text = selected_text + buf[end_row][:end_col+1];
	return selected_text;

def get_last_search_text():
	text = vim.eval('@/');
	if(text.startswith('\\<')):
		text = text[2:];
	if(text.endswith('\\>')):
		text = text[:len(text)-2];
	return text;

def insert_line(b, row, content):
	b[row:row] = [content];	

def set_line(b, row, content):
	b[row] = content;	

def get_filename_from_buffer(b):
	if(b.name):
		return os.path.basename(b.name);
	else:
		return "none";

def get_indent_str(line):
	indentstr='';
	for ch in line:
		if(ch.isspace()):
			indentstr=indentstr+ch;
		else:
			break;
	return indentstr;
