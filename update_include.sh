#!/usr/bin/ksh
#set -xv
atbuild=/export/jumpstart/misc/ENIQ/manifest/
list=$( find $atbuild | grep manifest.txt | sed -e 's|'"$atbuild"'||g' -e 's|/manifest.txt||g'
cdate=$( date "+%Y%m%d%H%M" )

include=/tmp/include_eniq.tmp
include_top=/tmp/include_top_eniq.tmp
include_bottom=/tmp/include_bottom_eniq.tmp
[ -f $include ] && rm $include
[ -f $include_top ] && rm $include_top
[ -f $include_bottom ] && rm $include_bottom

CWD=/opt/htdocs/bin/ENIQ_SEARCH

echo "// Project table" > $include
echo "//" >> $include
echo "// To edit the list, just delete a line or add a line. Order is important." >> $include
echo "// The order displayed here is the order it appears on the drop down." >> $include
echo "//" >> $include
echo "var media = '\\" >> $include

#list=$( find . $atbuild | grep -v misc | grep manifest.txt | sed -e 's|'"$atbuild"'||g' -e 's
touch $include_top
for a in $list; do
        RELEASE=$( echo $a | sed 's|/| |g' | awk '{print $1}' )
        SHIPMENT=$( echo $a | sed 's|/| |g' | awk '{print $2}' )
        BUILDTYPE=$( echo $a | sed 's|/| |g' | awk '{print $3}' )
        echo "${RELEASE}__${SHIPMENT}__${BUILDTYPE}" >> $include_top
done
# Hardcoding in a necessary EU option for the dropdown menu
echo "ENIQ_E13.2__3.2.7.EU1__LLSV3" >>$include_top
echo "ENIQ_E13.2__3.2.7.EU2__LLSV3" >>$include_top
echo "ENIQ_E13.2__3.2.7.EU3__LLSV3" >>$include_top

toplist=$( cat $include_top | sort | uniq )
for d in $toplist; do
        TOPRELEASE=$( echo $d | sed 's|__| |g' | awk '{print $1}' )
        TOPSHIPMENT=$( echo $d | sed 's|__| |g' | awk '{print $2}' )
        TOPBUILDTYPE=$( echo $d | sed 's|__| |g' | awk '{print $3}' )
        echo "${TOPRELEASE} ${TOPSHIPMENT}:${TOPBUILDTYPE}|\\" >> $include
done


echo "';" >> $include
echo "" >> $include
echo "//  data table" >> $include
echo "//" >> $include
echo "// To edit the list, just delete a line or add a line. Order is important." >> $include
echo "// The order displayed here is the order it appears on the drop down." >> $include
echo "//" >> $include
echo "var project = '\\" >> $include

touch $include_bottom
for b in $list; do
        RELEASE1=$( echo $b | sed 's|/| |g' | awk '{print $1}' )
        SHIPMENT1=$( echo $b | sed 's|/| |g' | awk '{print $2}' )
        echo "${RELEASE1} ${SHIPMENT1}" >> $include_bottom
done

# Hardcoding in a necessary EU option for the dropdown menu
echo "ENIQ_E13.2 3.2.7.EU1" >>$include_bottom
echo "ENIQ_E13.2 3.2.7.EU2" >>$include_bottom
echo "ENIQ_E13.2 3.2.7.EU3" >>$include_bottom

bottomlist=$( cat $include_bottom | sort | uniq | sed 's/ /__/g' )
for e in $bottomlist; do
        BOTTOMRELEASE1=$( echo $e | sed 's|__| |g' | awk '{print $1}' )
        BOTTOMSHIPMENT1=$( echo $e | sed 's|__| |g' | awk '{print $2}' )
        echo "${BOTTOMRELEASE1} ${BOTTOMSHIPMENT1}|\\" >> $include
done


echo "';" >> $include


if [ -f ${CWD}/include.js ]; then
        cp ${CWD}/include.js ${CWD}/include.js-${cdate}
        cp $include ${CWD}/include.js
fi
if [ -f ${CWD}/include_secship.js ]; then
        cp ${CWD}/include_secship.js ${CWD}/include_secship.js-${cdate}
        cat $include | sed -e 's/media/medias/' -e 's/project/projects/' > ${CWD}/include_secship.js_tmp
        mv ${CWD}/include_secship.js_tmp ${CWD}/include_secship.js
fi

#[ -f $include ] && rm $include
#[ -f $include_top ] && rm $include_top
#[ -f $include_bottom ] && rm $include_bottom
