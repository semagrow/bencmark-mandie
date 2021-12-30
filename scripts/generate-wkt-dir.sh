#!/bin/bash

SEQUENCE=`seq -w 0 99`

./generate-wkt-borders.sh > /tmp/wkts.txt

for i in $SEQUENCE
do
  N=`expr $i + 1`
  cat /tmp/wkts.txt | head -n $N | tail -n 1 > wkt.$i.txt
done

rm /tmp/wkts.txt
