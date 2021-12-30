#!/bin/bash

SOURCES_DIR="sources-1sec"
SLEEP_TIME="120"

screen -dm ssh -L 6443:10.0.10.10:6443 iitadmin@bdegw.iit.demokritos.gr -p 222

# create namespaces
seq 0 9 | xargs -I{} kubectl create namespace pbbench{}

# enable istio in all namespaces
seq 0 9 | xargs -I{} kubectl label namespace pbbench{} istio-injection=enabled

# apply memory-defaults in all namespaces
seq 0 9 | xargs -I{} kubectl apply -f memory-defaults.yaml -n pbbench{}

# apply the yamls for all datasets and sleep for some time...
cd $SOURCES_DIR
for i in `seq 0 9`; do kubectl apply -f pbbench$i.yaml; sleep $SLEEP_TIME; done

# apply the yaml containing the queries
cd ..
kubectl create namespace pbbench
kubectl label namespace pbbench istio-injection=enabled
kubectl apply -f pbbench.yaml

# check if all strabon pods are full 
# ( result should be 10 * 10 = 100 )
for i in `seq 0 9`; do for j in `seq 0 9`; do kubectl -n pbbench$i logs pbd$i$j-pod | grep "Server startup in"; done done | wc -l

# apply strabon template and experiment
cd ../experiments
kubectl apply -f semagrowpbtemplate.yaml
kubectl apply -f exp-pbbench.yaml
