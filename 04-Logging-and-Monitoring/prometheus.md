Step-by-Step Guide
Install Prometheus Node Exporter using Helm

First, ensure you have Helm installed. If not, you can install it following the instructions from the Helm documentation.

Add the Prometheus Community Helm repo:

```bash

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```
Install the Prometheus Node Exporter chart:

```bash

helm install node-exporter prometheus-community/prometheus-node-exporter
```
Verify the Installation

Check if the Node Exporter pods are running:

```bash

kubectl get pods -l app.kubernetes.io/name=prometheus-node-exporter
```
You should see one or more pods with the name prometheus-node-exporter running.

Expose the Node Exporter

By default, the Node Exporter runs as a DaemonSet and exposes metrics on port 9100. To check if it's working, you can port-forward to one of the Node Exporter pods:

```bash

kubectl port-forward <node-exporter-pod-name> 9100:9100
```
Then, open your browser and go to http://localhost:9100/metrics to see the metrics being exported.

Configure Prometheus to Scrape Node Exporter Metrics

If you already have Prometheus running in your cluster, you need to configure it to scrape metrics from the Node Exporter. Add the following scrape configuration to your Prometheus configuration file:

```yaml

scrape_configs:
  - job_name: 'node-exporter'
    kubernetes_sd_configs:
      - role: pod
    relabel_configs:
      - source_labels: [__meta_kubernetes_pod_label_app_kubernetes_io_name]
        action: keep
        regex: prometheus-node-exporter
      - source_labels: [__address__]
        target_label: __address__
        regex: (.*):\d+
        replacement: ${1}:9100
```
Update your Prometheus configuration and reload the Prometheus server. This can typically be done by updating the ConfigMap and restarting the Prometheus pod:

```bash

kubectl edit configmap prometheus-config
```
Make the necessary changes and save. Then restart the Prometheus server:

```bash

kubectl rollout restart deployment prometheus-server
```
Verify Prometheus is Scraping Node Exporter Metrics

Access the Prometheus UI and navigate to the Targets page (http://<prometheus-server>:9090/targets). You should see the node-exporter targets listed and marked as UP.

Conclusion
This setup will allow Prometheus to scrape metrics from the Node Exporter running on each node in your Kubernetes cluster. You can now use these metrics for monitoring and alerting purposes.

Add Prometheus as a Data Source in Grafana

Once logged in to Grafana:

Navigate to Configuration -> Data Sources.
Click Add data source.
Select Prometheus.
Set the URL to http://<prometheus-service>:9090. If Prometheus is running in the same cluster, you can use the Kubernetes service name, such as http://prometheus-server.default.svc.cluster.local:9090.
Click Save & Test to verify the connection.
Create Dashboards in Grafana

Now that Prometheus is added as a data source, you can create dashboards to visualize the metrics:

Navigate to Create -> Dashboard.
Click Add new panel.
Set up a query to display the desired metrics from Prometheus.
Save the dashboard.
Detailed Commands and Configuration Files
Prometheus Configuration (prometheus-config.yaml):

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  
  - job_name: 'node-exporter'
    kubernetes_sd_configs:
      - role: pod
    relabel_configs:
      - source_labels: [__meta_kubernetes_pod_label_app_kubernetes_io_name]
        action: keep
        regex: prometheus-node-exporter
      - source_labels: [__address__]
        target_label: __address__
        regex: (.*):\d+
        replacement: ${1}:9100
```