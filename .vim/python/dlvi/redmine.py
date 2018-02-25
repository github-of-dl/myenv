#!/bin/python
# -*- coding: utf-8 -*-

import urllib
#import urllib2

import httplib2
from pyquery import PyQuery as pq

import re
from xml.dom import minidom

def login(login_url, username, password):
	'''
		try to login @login_url with @username and @password
		return (http, headers)
	'''
	headers={
		'Host': '10.10.48.243:8080',
		'Referer': 'http://10.10.48.243:8080/redmine/login',
		'Content-Type': 'application/x-www-form-urlencoded',
		'Accept-Language': 'zh-CN,zh;q=0.8',
		'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:23.0) Gecko/20100101 Firefox/23.0'
	}

	#httplib2.debuglevel=1
	h = httplib2.Http()
	res, content = h.request(login_url, headers=headers);
	headers['Cookie'] = res['set-cookie']
	content = content.decode('utf-8');

	# find login form
	data = {'username': username, 'password': password }
	pq_all = pq(content);
	pq_login_form = pq_all('form').filter(lambda i,this: this.attrib['action']=='/redmine/login');
	# get all hidden input
	for ipt in pq_login_form('input'):
		if(ipt.attrib['type'] == 'hidden'):
			value = ipt.attrib['value'];
			value = value.encode('utf8');	
			data[ipt.name] = value;

	post_data = urllib.urlencode(data)
	
	res, content = h.request(login_url, method="POST", body=post_data, headers=headers)
	headers['Cookie'] = res['set-cookie']
	return (h, headers);

def get_redmines(http, headers, url):
	res, content = http.request(url, headers=headers);
	content = content.decode('utf-8');

	redmines={}

	redmine_id=0
	redmine_subject='Empty'

	# find all redmine
	pq_all = pq(content);
	pq_tbody = pq_all('tbody');
	pq_tr = pq_tbody('tr');
	for tr in pq_tr.items():
		for td in tr('td'):
			if(td.attrib['class'] == 'id'):
				redmine_id = int(pq(td)('a').text());
			elif(td.attrib['class'] == 'subject'):
				redmine_subject = pq(td)('a').text();
		redmines[redmine_id]=redmine_subject;

	return redmines;

# if __name__ == '__main__':
# 	http, headers = login('http://10.10.48.243:8080/redmine/login', 'wangdonglei', 'wangdonglei');
# 	redmines = get_redmines(http, headers, 'http://10.10.48.243:8080/redmine/projects/g1-005/issues?query_id=192');
# 	for k,v in redmines.iteritems():
# 		print('#%d %s' %(k,v));
# 	redmines = get_redmines(http, headers, 'http://10.10.48.243:8080/redmine/projects/g1-005/issues?query_id=195');
# 	for k,v in redmines.iteritems():
# 		print('#%d %s' %(k,v));
