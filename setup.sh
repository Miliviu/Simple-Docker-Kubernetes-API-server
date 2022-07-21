#!/bin/bash
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

if [ "$1" = "start" ]; then
    eval $(minikube docker-env)
    kubectl apply -f kube/config-map.yaml
    kubectl apply -f kube/service.yaml
    kubectl apply -f kube/deployment.yaml
    sleep 10
    printf "${GREEN}Starting Kubernetes deployment, press CTRL+C to stop${NC}\n"
    minikube service flask
elif [ "$1" == "build" ]; then
    printf "${GREEN}Building Docker image${NC}"
    eval $(minikube docker-env)
    docker build -f docker/flask/Dockerfile -t localhost:5000/flask .
    docker push localhost:5000/flask
elif [ "$1" == "stop" ]; then
    kubectl delete configmap/flask-nginx service/flask deployment.apps/flask
elif [ "$1" == "restart" ]; then
    eval $(minikube docker-env)
    kubectl delete configmap/flask-nginx service/flask deployment.apps/flask
    sleep 3
    kubectl apply -f kube/config-map.yaml
    kubectl apply -f kube/service.yaml
    kubectl apply -f kube/deployment.yaml
    sleep 10
    printf "${GREEN}Starting Kubernetes deployment, press CTRL+C to stop${NC}\n"
    minikube service flask
else
    printf "${RED}The VALID options are Start, Build, Restart, Stop${NC}\n"
fi
