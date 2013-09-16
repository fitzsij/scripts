#!/bin/bash

#1089

$SHIPMENT
$PACKAGE
$USERNAME
$PASSWORD


# enter your details
echo "Enter username:"
read USERNAME
read -s -p Password: PASSWORD
#haven't got this 'new line' right yet
echo -e "\nEnter shipment:"
read SHIPMENT
echo 'Enter package:'
read PACKAGE

echo "$USERNAME $SHIPMENT $PACKAGE"
#download the full webpage as a .html file
wget --user=$USERNAME --password=$PASSWORD  http://clearcase-oss.lmera.ericsson.se/view/www_eniq/vobs/ossrc/del-mgt/html/eniqdel\/$SHIPMENT\/$PACKAGE\/SOLARIS_baseline.html

#filter out the names, product numbers and pack
cat SOLARIS_baseline.html | egrep "<\!.*>" | sed s/"<tr><td><a href=\"http:\/\/clearcase-oss.lmera.ericsson.se\/view\/www_eniq\/vobs\/ossrc\/del-mgt\/html\/eniqdel\/$SHIPMENT\/$PACKAGE\/.*\">"/" "/g | egrep "_NAME" | sed s/"<\/a><\/td><\!.*>"/" "/g > Names.txt

cat SOLARIS_baseline.html | egrep "<\!.*>" | sed s/"<tr><td><a href=\"http:\/\/clearcase-oss.lmera.ericsson.se\/view\/www_eniq\/vobs\/ossrc\/del-mgt\/html\/eniqdel\/$SHIPMENT\/$PACKAGE\/.*\">"/" "/g | egrep "_RSTATE" | sed s/"<\/a><\/td><\!.*>"/" "/g | sed s/"<td>"/" "/g | sed s/"<\/td><\!.*>"/" "/g > RStates.txt

cat SOLARIS_baseline.html | egrep "<\!.*>" | sed s/"<tr><td><a href=\"http:\/\/clearcase-oss.lmera.ericsson.se\/view\/www_eniq\/vobs\/ossrc\/del-mgt\/html\/eniqdel\/$SHIPMENT\/$PACKAGE\/.*\">"/" "/g | sed s/"<td>"/" "/g | egrep "_ProductNo" | sed s/"<\/td><\!.*>"/" "/g > ProductNos.txt

#puts them into the one file
paste -d ',' Names.txt ProductNos.txt RStates.txt > Webpage_Packages_$SHIPMENT_$PACKAGE_$(date +%Y%m%d).txt

#remove the created files to clean up the folder
echo `rm -f Names.txt`
echo `rm -f ProductNos.txt`
echo `rm -f RStates.txt`
echo `rm -f SOLARIS_baseline.html`


# 884
# gunzip -c ENIQ_E13.0_3.0.14_EU8.tar.gz | tar tvf - > /net/159.107.173.47/tmp/ejulfit/scripts/Tar_Packages_$SHIPMENT_$PACKAGE_$(date +%Y%m%d).txt
# cat Tar_Packages_$SHIPMENT_$PACKAGE_$(date +%Y%m%d).txt | awk -F"/" '{print $NF}'
touch /net/159.107.173.47/tmp/ejulfit/scripts/TEST.txt
# ENIQ_E14.0
# 4.0.3