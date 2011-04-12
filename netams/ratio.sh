#!/bin/sh

prefix='M'
policy_oid='26632'
myhost='localhost'
mybase='netams'
myuser='netams'
mypass='netamspwd'
ratio=5

rcpt="m.klopotnuk@gmail.com,valentinkomkov@gmail.com"   # Recipients
subject="OUT_IN_RATIO_LESS_$ratio"




curdate=`date "+%Y-%m-01"`
cdate=`date -d $curdate +%s`

in=`mysql -N -s -h $myhost -u $myuser  -p$mypass $mybase -e "select bytes_in from summary where prefix='$prefix' and policy_oid='$policy_oid' and t_from='$cdate';"`
out=`mysql -N -s -h $myhost -u $myuser  -p$mypass $mybase -e "select bytes_out from summary where prefix='$prefix' and policy_oid='$policy_oid' and t_from='$cdate';"`

let "i = $out/$in"
#echo $i

if [ $i -le $ratio ]; then
 echo $out"/"$in"="$i | mail -s $subject $rcpt
fi