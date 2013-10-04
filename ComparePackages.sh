#!/bin/bash

#1089

$SHIPMENT
$PACKAGE
$USERNAME
$PASSWORD
$DESTINATION = "/net/159.107.173.47/tmp/ejulfit"


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
wget --user=$USERNAME --password=$PASSWORD  http://clearcase-oss.lmera.ericsson.se/view/www_eniq/vobs/ossrc/del-mgt/html/eniqdel\/$SHIPMENT\/$PACKAGE\/ec\/SOLARIS_baseline.html

#filter out the names, product numbers and packages
cat SOLARIS_baseline.html | egrep "<\!.*>" | sed s/"<tr><td><a href=\"http:\/\/clearcase-oss.lmera.ericsson.se\/view\/www_eniq\/vobs\/ossrc\/del-mgt\/html\/eniqdel\/$SHIPMENT\/$PACKAGE\/.*\">"/" "/g | egrep "_NAME" | sed s/"<\/a><\/td><\!.*>"/" "/g > $DESTINATION/Names.txt

cat SOLARIS_baseline.html | egrep "<\!.*>" | sed s/"<tr><td><a href=\"http:\/\/clearcase-oss.lmera.ericsson.se\/view\/www_eniq\/vobs\/ossrc\/del-mgt\/html\/eniqdel\/$SHIPMENT\/$PACKAGE\/.*\">"/" "/g | egrep "_RSTATE" | sed s/"<\/a><\/td><\!.*>"/" "/g | sed s/"<td>"/" "/g | sed s/"<\/td><\!.*>"/" "/g > $DESTINATION/RStates.txt

cat SOLARIS_baseline.html | egrep "<\!.*>" | sed s/"<tr><td><a href=\"http:\/\/clearcase-oss.lmera.ericsson.se\/view\/www_eniq\/vobs\/ossrc\/del-mgt\/html\/eniqdel\/$SHIPMENT\/$PACKAGE\/.*\">"/" "/g | sed s/"<td>"/" "/g | egrep "_ProductNo" | sed s/"<\/td><\!.*>"/" "/g > $DESTINATION/ProductNos.txt

#puts them into one file
paste -d ',' $DESTINATION/Names.txt $DESTINATION/ProductNos.txt $DESTINATION/RStates.txt > $DESTINATION/Webpage_Packages_$SHIPMENT_$PACKAGE_$(date +%Y%m%d).txt

#remove the created files to clean up the folder
echo `rm -f Names.txt`
echo `rm -f ProductNos.txt`
echo `rm -f RStates.txt`
echo `rm -f SOLARIS_baseline.html`

gunzip -c /net/159.107.177.67/export/jumpstart/$SHIPMENT/$PACKAGE/tar/*.tar.gz | tar tvf - > $DESTINATION/Tar_Packages_$SHIPMENT_$PACKAGE_$(date +%Y%m%d).txt
# 884
cat Tar_Packages_$SHIPMENT_$PACKAGE_$(date +%Y%m%d).txt | awk -F"/" '{print $NF}'
echo "Check your work in $DESTINATION"
echo `cd $DESTINATION && ls`
# ENIQ_E13.2
# 3.2.6_eu1