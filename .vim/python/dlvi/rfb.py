# Remote FeedBack
# send something in vim to localhost
#	example: Select a couple of lines and send to clipboard of localhost.

import vim
import os
import re
import time
import struct
import socket

MSGID_CLIPBOARD=1		# copy msg-body to clipboard

def send_msg(ip, port, msgid, data):
	fmt_str = "!II%ds" %(len(data));
	msg = struct.pack(fmt_str, msgid,8+len(data), bytes(data,'utf8'));

	sock = socket.socket( socket.AF_INET, socket.SOCK_STREAM)
	sock.settimeout(1);
	sock.connect((ip, port))
	sock.sendall(msg, 0);
	sock.close();

def send_to_host_clipboard(ip, port, data):
	try:
		send_msg(ip, port, MSGID_CLIPBOARD, data);
	except:
		pass
