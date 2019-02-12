#!/bin/bash

HOSTR="$1"
USERIDR="$2"
PASSWDR="$3"
PATHDIR="/root/GetListUsers/"
UNAMEA=""
NAMAHOST=""
##GET UNAME
UNAMEA=$(sshpass -p $PASSWDR ssh -o StrictHostKeyChecking=no $USERIDR@$HOSTR 'uname -a');

##GET HOSTNAME
NAMAHOST=$(sshpass -p $PASSWDR ssh -o StrictHostKeyChecking=no $USERIDR@$HOSTR 'hostname');

##GET ETC PASSWD
sshpass -p $PASSWDR ssh -o StrictHostKeyChecking=no $USERIDR@$HOSTR 'getent passwd' > $PATHDIR$HOSTR"-passwd.txt" && cat $PATHDIR$HOSTR"-passwd.txt" | awk -F":" '{ print $1 "," $2 "," $3 "," $4 "," $5 "," $6 "," $7 "," "'"$HOSTR"'" "," "'"$NAMAHOST"'" "," "'"$UNAMEA"'" }' > $PATHDIR$HOSTR"-passwd.csv";
printf "Export ETC-PASSWD Successfull\n";
sleep 1s;
###GET ETC GROUP
sshpass -p $PASSWDR ssh -o StrictHostKeyChecking=no $USERIDR@$HOSTR 'getent group' > $PATHDIR$HOSTR"-group.txt"  && cat $PATHDIR$HOSTR"-group.txt" | awk -F":" '{ print $1 "," $2 "," $3 "," $4 "," "'"$HOSTR"'" }' > $PATHDIR$HOSTR"-group.csv";
printf "Export ETC-GROUP Successfull\n";

###GET SUDOERS
sshpass -p $PASSWDR ssh -o StrictHostKeyChecking=no $USERIDR@$HOSTR 'cat /etc/sudoers' > $PATHDIR$HOSTR"-sudoers.txt" && cat $PATHDIR$HOSTR"-sudoers.txt" | egrep -v "^\s*(#|$)" > $PATHDIR$HOSTR"-sudoers.csv";
printf "Export ETC-SUDOERS Successfull\n";
