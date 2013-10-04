import re
import urllib2
import getpass

def get_hyperlinks(url, source):
    if url.endswith("/"):
        url = url[:-1]
    urlPat = re.compile(r'<a [^<>]*?href=("|\')([^<>"\']*?)("|\')')
    result = re.findall(urlPat, source)
    urlList = []

    for item in result:
        link = item[1]
        if link.startswith("http://") and link.startswith(url):
            if link not in urlList:
                urlList.append(link)
        elif link.startswith("/"):
            link = url + link
            if link not in urlList:
                urlList.append(link)
        else:
            link = url + "/" + link
            if link not in urlList:
                urlList.append(link)
                print link
    text_file = open("packageList.txt", "w")
    text_file.write(str(urlList))
    text_file.close()
    return urlList

def getPackages(urls):
    print urls
    packages=[]
    for item in urls:    
        #if item.startswith("http://clearcase-oss.lmera.ericsson.se/view/www_eniq/vobs/ossrc/del-mgt/html/eniqdel/ENIQ_E13.2/3.2.7/ec/"):
        list2= "http://clearcase-oss.lmera.ericsson.se/view/www_eniq/vobs/ossrc/del-mgt/html/eniqdel/ENIQ_E13.2/3.2.7/ec/"
        if list2 in item: 
            print ("\nhoooooooooo | "+item)
            packages.append(item)
    #print packages
    return packages

def printArray(array[]):
    for i in array:
        print i +"\n"
    











print "Enter the URL: "
url = http://clearcase-oss.lmera.ericsson.se/view/www_eniq/vobs/ossrc/del-mgt/html/eniqdel/ENIQ_E13.2/3.2.7/ec/SOLARIS_baseline.html
#url = raw_input("> ")
#print "Enter username: "
user="ejulfit"
password = getpass.getpass('Enter your password, EJULFIT: ')
proxy_handler = urllib2.ProxyHandler({'https': 'https://www-proxy.ericsson.se:8080'})
passman = urllib2.HTTPPasswordMgrWithDefaultRealm()
passman.add_password(None, url, user, password)
authhandler = urllib2.HTTPBasicAuthHandler(passman)
opener = urllib2.build_opener(proxy_handler,authhandler)
urllib2.install_opener(opener)
req=urllib2.Request(url)
f=urllib2.urlopen(req)
data=f.read()
f.close()
usock = urllib2.urlopen(url)
data = usock.read()
usock.close()

getPackages(get_hyperlinks(url, data))


#http://clearcase-oss.lmera.ericsson.se/view/www_eniq/vobs/ossrc/del-mgt/html/eniqdel/ENIQ_E13.2/3.2.7/ec/SOLARIS_baseline.html