#!/bin/bash
##VER=$(curl -s https://api.github.com/repos/weaveworks/scope/releases/latest|grep tag_name|cut -d '"' -f 4|sed 's/v//')
##kubectl apply -f https://github.com/weaveworks/scope/releases/download/v$VER/k8s-scope.yaml
kubectl apply -f ./k8s-scope.yaml
## Expose using NodePort ###
kubectl --namespace weave patch svc weave-scope-app -p '{"spec": {"type": "NodePort"}}'