#!/bin/bash

SEQUENCE=`seq 0 9`
E="0.0000001"
XSTEP="9"
YSTEP="7.795"

for i in $SEQUENCE
do
  for j in $SEQUENCE
  do
    echo -n "POLYGON (("
    
    x1=`echo $i \* $XSTEP + $E | bc`
    y1=`echo $j \* $YSTEP | bc`
    
    x2=`echo $i \* $XSTEP + $XSTEP | bc`
    y2=`echo $j \* $YSTEP + $YSTEP - $E | bc`
    
    echo -n $x1" "$y1","
    echo -n $x2" "$y1","
    echo -n $x2" "$y2","
    echo -n $x1" "$y2","
    echo -n $x1" "$y1
    
    echo -n "))"
    echo
  done
done
