# deploying-scalabale-applications
deploying scalabale applications
Prerequisites
Minikube: Ensure Minikube is installed and running on your local machine.
kubectl: Ensure kubectl is configured to interact with your Minikube cluster.
Step 1: Start Minikube
Start Minikube with sufficient resources:

sh
Copy code
minikube start --cpus=4 --memory=8192
Apply the deployment:

Set Up a Sample Application
Create a simple deployment for testing. Save the following YAML to a file named nginx-deployment.yaml:sh
Copy code
kubectl apply -f nginx-deployment.yaml
Test Horizontal Pod Autoscaler (HPA)
1. Create the HPA Configuration

Save the following YAML to a file named hpa.yaml:

Apply the HPA configuration:

sh
Copy code
kubectl apply -f hpa.yaml

Generate CPU Load

To test HPA, you need to generate CPU load. You can use a load testing tool or create a busybox pod to simulate load. Save the following YAML to a file named busybox-load.yaml

Monitor HPA

Check the status of the HPA:

sh
Copy code
kubectl get hpa

Test Vertical Pod Autoscaler (VPA)
1. Create VPA Configuration

Minikube does not support VPA out of the box, so you'll need to install it manually. First, deploy the VPA components. Save the following YAML to a file named vpa-components.yaml:

Apply the VPA components:

sh
Copy code
kubectl apply -f vpa-components.yaml

Create VPA Configuration for Deployment

Save the following YAML to a file named vpa.yaml:

Monitor VPA

Check the VPA status:

sh
Copy code
kubectl get vpa
kubectl describe vpa nginx-vpa