#!/bin/bash

SEQUENCE=`seq 0 9`

DELAY='1'
PERC='100'
URL='https://users.iit.demokritos.gr/~antru/dumps/pb/pbdataset'

for i in $SEQUENCE
do
  echo 'apiVersion: kobe.semagrow.org/v1alpha1' >> pbbench$i.yaml
  echo 'kind: Benchmark'     >> pbbench$i.yaml
  echo 'metadata:'           >> pbbench$i.yaml
  echo '  name: pbbench'$i   >> pbbench$i.yaml
  echo 'spec:'               >> pbbench$i.yaml
  echo '  datasets:'         >> pbbench$i.yaml
  
  for j in $SEQUENCE
  do
    echo '    - name: pbd'$i$j                  >> pbbench$i.yaml
    echo '      files:'                         >> pbbench$i.yaml
    echo '        - url: '$URL'.'$i$j'.tar.gz'  >> pbbench$i.yaml
    echo '      templateRef: strabontemplate'   >> pbbench$i.yaml
    echo '      federatorConnection:'           >> pbbench$i.yaml
    echo '         delayInjection:'             >> pbbench$i.yaml
    echo '           fixedDelaySec: '$DELAY     >> pbbench$i.yaml
    echo '           percentage: '$PERC         >> pbbench$i.yaml
  done
  
  echo '  queries:'              >> pbbench$i.yaml
  echo '    - name: dummy'       >> pbbench$i.yaml
  echo '      language: sparql'  >> pbbench$i.yaml
  echo '      queryString: ""'   >> pbbench$i.yaml
done
