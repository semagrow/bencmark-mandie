#!/bin/bash

for f in `ls *.nt`
do
  tail $f -n 4 | sed 's|/1/|/512/|g' | sed 's|"1"|"512"|g' > /tmp/dummy.nt
  cat $f /tmp/dummy.nt > /tmp/data.nt
  mv /tmp/data.nt $f
done
