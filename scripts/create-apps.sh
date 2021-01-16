#!/bin/sh

argocd app create apps \
    --dest-namespace argocd \
    --dest-server https://kubernetes.default.svc \
    --repo https://github.com/renanpolisciuc/argocd.git \
    --path cicd/apps  
argocd app sync apps  