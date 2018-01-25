import sys
import os
import socket
import struct
import pyperclip
import time

LISTEN_PORT=21032

# message id
MSGID_CLIPBOARD=1       # copy msg-body to clipboard



def set_clipboard(text):
    pyperclip.copy(text);

def process_msg(msgid, msglen, buff, logfile):
    #print(msgid,msglen);
    if(msgid==MSGID_CLIPBOARD):
        tmp=buff[8:msglen];
        tmp=tmp.decode('utf-8');
        set_clipboard(tmp);
        LOG(logfile, 'msgid[%d] msglen[%d] msg[%s]' %(msgid, msglen, tmp));

def LOG(logfile, log):
    logfile.write(log + '\n');
    logfile.flush();
    
'''
    create socket server
    receive and process msg from remote server
'''
if __name__ == '__main__':
    
    # log file
    logfile=open('log.txt','a');
    LOG(logfile, "init server...");
    
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM);
        sock.bind(('0.0.0.0',LISTEN_PORT));
        sock.listen(20);
        LOG(logfile, "start to listen port[%d]" %(LISTEN_PORT));
    
        buff=bytearray(1024*1024*1);
    
        while(True):
            (client_sock, address) = sock.accept();
            LOG(logfile, 'new connection: ip[%s] port[%d]' %(address[0], address[1]));
            recvd_len=0

            # receive msgheader: msgid(4byte) | msglen(4byte)
            while(recvd_len<8):
                recvd_str = client_sock.recv(100);
                for i in range(0,len(recvd_str)):
                    buff[recvd_len+i] = recvd_str[i];
                recvd_len += len(recvd_str);
            (msgid, msglen) = struct.unpack('!II',buff[0:8]);

            # receive msgbody
            while(recvd_len<msglen):
                recvd_str = client_sock.recv(100);
                for i in range(0,len(recvd_str)):
                    buff[recvd_len+i] = recvd_str[i];
                recvd_len += len(recvd_str);
            process_msg(msgid, msglen, buff, logfile);

            client_sock.close();
    except  Exception as e:
        LOG(logfile, 'exception: [%s]' %(str(e)));
    LOG(logfile, 'server exit');
    logfile.close();
