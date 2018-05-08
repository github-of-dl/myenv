#!/bin/python
#-*-coding: utf8 -*-
#

import time
import sys


def get_curms():
    timems = int(time.time()*1000.0);
    timesec = timems/1000;
    timems = timems-timesec*1000;
    return "%d,%d" %(timesec,timems);

def get_cursec():
    return int(time.time());

def wait_input_with_timeout(timeout=1):
    pass

def input_thread_func(queue):
    while(True):
        try:
            inputstr = raw_input('>');
        except EOFError:
            sys.exit(1);
        queue.put(inputstr);

def assert_version(version):
	assert(sys.version_info.major==version);
