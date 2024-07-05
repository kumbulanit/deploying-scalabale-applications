#!/bin/bash

# Variables
NAMESPACE="default" # Change this to your namespace
DEPLOYMENT_NAME="hpav1-web" # Change this to your deployment name
SERVICE_NAME="hpa-service" # Change this to your service name
LOAD_DURATION="300s" # Duration for how long to send load
CONCURRENT_REQUESTS=1000 # Number of concurrent requests
REQUESTS_PER_SECOND=1000 # Number of requests per second

# Function to get pod IPs
get_pod_ips() {
  kubectl get pods -n $NAMESPACE -l app=$DEPLOYMENT_NAME -o jsonpath='{.items[*].status.podIP}'
}

# Function to send load to pods
send_load() {
  POD_IPS=$(get_pod_ips)

  for IP in $POD_IPS; do
    echo "Sending load to pod with IP: $IP"
    hey -z $LOAD_DURATION -c $CONCURRENT_REQUESTS -q $REQUESTS_PER_SECOND http://$IP
  done
}

# Send load
send_load

