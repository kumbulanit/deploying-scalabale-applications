#!/bin/bash
echo minikube $(kubectl --context minikube top pods -A --no-headers | sort -nr -k3 | head -1) > /tmp/high_cpu_pod
echo minikube $(kubectl --context minikube  top pods -A --no-headers | sort -nr -k3 | head -1) >> /tmp/high_cpu_pod
echo minikube $(kubectl --context minikube top pods -A --no-headers | sort -nr -k3 | head -1) >> /tmp/high_cpu_pod
echo minikube $(kubectl --context minikube top pods -A --no-headers | sort -nr -k3 | head -1) >> /tmp/high_cpu_pod
final_value=$(cat /tmp/high_cpu_pod | sort -nr -k 4 | awk '{print $1,$2,$3}' | head -1 | tr " " ,)
if [[ $(cat /opt/high_cpu_pod | grep $final_value) ]]
then 
        echo SUCCESS
else
        echo FAIL
fi
