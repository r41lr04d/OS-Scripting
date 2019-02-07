#!/bin/bash

HOSTR="$1"
USERIDR="$2"
PASSWDR="$3"
PATHDIR="/root/GetListUsers/"
sshpass -p $PASSWDR ssh -o StrictHostKeyChecking=no $USERIDR@$HOSTR 'getent passwd' > $PATHDIR$HOSTR".txt" && cat $PATHDIR$HOSTR".txt" | awk -F":" '{ print $1 "," $2 "," $3 "," $4 "," $5 "," $6 "," $7 "," "'"$HOSTR"'" }' > $PATHDIR$HOSTR".csv"
