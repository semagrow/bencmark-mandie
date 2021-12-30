#!/bin/bash

SEQUENCE=`seq -w 0 99`

for i in $SEQUENCE
do
  cat $1"/state."$i.nt $1"/landOwnership."$i.nt $1"/pointOfInterest."$i.nt > "pbdataset."$i".nt"
  mkdir "pbdataset."$i
  mv "pbdataset."$i".nt" "pbdataset."$i
  tar czvf "pbdataset."$i".tar.gz" "pbdataset."$i
done