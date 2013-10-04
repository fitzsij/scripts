#!/usr/bin/python

import urllib,urllib2, re

#input url
url="http://clearcase-oss.lmera.ericsson.se/view/www_eniq/vobs/ossrc/del-mgt/html/eniqdel/ENIQ_E13.2/3.2.7/ec/SOLARIS_baseline.html"
contents=""

def openPage(url):
	#proxy set up
	proxy_handler = urllib2.ProxyHandler({'https': 'https://www-proxy.ericsson.se:8080'})
	#htaccess set up
	user="ejulfit"
	password="Malachy1"
	passman = urllib2.HTTPPasswordMgrWithDefaultRealm()
	passman.add_password(None, url, user, password)
	authhandler = urllib2.HTTPBasicAuthHandler(passman)
	opener = urllib2.build_opener(proxy_handler,authhandler)
	urllib2.install_opener(opener)
	try:
		#open the url
		req=urllib2.Request(url)
		f=urllib2.urlopen(req)
		page=f.read()
		f.close()
		contents=page
		return page
	except:
		return ""
	return ""
openPage(url)

print contents

def get_next_target(page):
    start_link = page.find('<tr><td><a href=')
    if start_link == -1:
        return None, 0
    start_quote = page.find('"', start_link)
    end_quote = page.find('"', start_quote + 1)
    url = page[start_quote + 1:end_quote]
    return url, end_quote


get_next_target(contents)



def get_all_links(page):
    links = []
    while True:
        url,endpos = get_next_target(page)
        if url:
            links.append(url)
            page = page[endpos:]
        else:
            break
    print links
    return links


get_all_links(contents)


