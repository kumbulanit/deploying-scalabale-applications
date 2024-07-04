#!/bin/bash
echo minikube $(kubectl --context minikube top node --no-headers | sort -nr -k2 | head -1) > /tmp/high_cpu_node
echo minikube $(kubectl --context minikube top node --no-headers | sort -nr -k2 | head -1) >> /tmp/high_cpu_node
echo minikube $(kubectl --context minikube top node --no-headers | sort -nr -k2 | head -1) >> /tmp/high_cpu_node
echo minikube $(kubectl --context minikube top node --no-headers | sort -nr -k2 | head -1) >> /tmp/high_cpu_node
final_value=$(cat /tmp/high_cpu_node | sort -nr -k 3 | awk '{print $1,$2}' | head -1 | tr " " ,)
if [[ $(cat /opt/high_cpu_node | grep $final_value) ]]
then 
        echo SUCCESS
else
        echo FAIL
fi
