Cluster Logging with Elasticsearch and Fluentd
1.1 Elasticsearch
Elasticsearch is a search and analytics engine that stores and indexes log data, allowing you to search, analyze, and visualize it.

Setup Steps:

Install Elasticsearch:

Use Helm to deploy Elasticsearch to your Kubernetes cluster:

```sh

helm repo add elastic https://helm.elastic.co
helm repo update
helm install elasticsearch elastic/elasticsearch
```
Alternatively, you can use a YAML manifest to deploy Elasticsearch.

Configure Elasticsearch:

Ensure that Elasticsearch is correctly configured to handle your expected log volume and retention policies.
Access Elasticsearch:

Access Elasticsearch using its service endpoint, often exposed via a LoadBalancer or NodePort.
1.2 Fluentd
Fluentd is a log collector and forwarder that gathers logs from various sources, processes them, and sends them to storage systems like Elasticsearch.

Setup Steps:

Install Fluentd:

Use Helm to deploy Fluentd:

```sh
helm install fluentd stable/fluentd
```
Alternatively, use a YAML manifest to deploy Fluentd.

Configure Fluentd:

Configure Fluentd to collect logs from Kubernetes. You can use Fluentd’s Kubernetes plugin to gather logs from Pod containers.

Example configuration for Fluentd (fluentd-configmap.yaml):

yaml

apiVersion: v1
kind: ConfigMap
metadata:
  name: fluentd-config
data:
  fluentd.conf: |
    <source>
      @type kubernetes
      @id input_kubernetes
      @label @FLUENTD
    </source>

    <match **>
      @type elasticsearch
      @id output_elasticsearch
      host "elasticsearch.default.svc.cluster.local"
      port 9200
      logstash_format true
      include_tag_key true
      type_name "fluentd"
      </match>
Deploy Fluentd:

Apply the ConfigMap and Deployment to your cluster:

```sh

kubectl apply -f fluentd-configmap.yaml
kubectl apply -f fluentd-deployment.yaml
```
1.3 Visualizing Logs
Use Kibana (which often comes bundled with Elasticsearch) to visualize and analyze the logs collected by Fluentd.

Install Kibana using Helm:

```sh

helm install kibana elastic/kibana
```

2. Container-Level Monitoring
2.1 cAdvisor
cAdvisor (Container Advisor) is a tool for monitoring container performance metrics.

Setup Steps:

Deploy cAdvisor:

Run cAdvisor as a Docker container or deploy it in Kubernetes:

```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: cadvisor
spec:
  replicas: 1
  selector:
    matchLabels:
      app: cadvisor
  template:
    metadata:
      labels:
        app: cadvisor
    spec:
      containers:
      - name: cadvisor
        image: google/cadvisor:latest
        ports:
        - containerPort: 8080
```
Access cAdvisor:

Expose cAdvisor via a Kubernetes Service to access its web UI.

```yaml

apiVersion: v1
kind: Service
metadata:
  name: cadvisor
spec:
  ports:
  - port: 8080
    targetPort: 8080
  selector:
    app: cadvisor
```
2.2 InfluxDB
InfluxDB is a time-series database optimized for storing and querying metrics.

Setup Steps:

Install InfluxDB:

Deploy InfluxDB using Helm or YAML manifests:

```sh
helm install influxdb bitnami/influxdb
```
Configure InfluxDB:

Set up retention policies and databases for storing metrics.
Access InfluxDB:

Expose InfluxDB via a Kubernetes Service for querying.
2.3 Prometheus
Prometheus is a monitoring and alerting toolkit widely used in Kubernetes environments.

Setup Steps:

Install Prometheus:

Use Helm to deploy Prometheus:

```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus
```
Alternatively, use the Prometheus Operator for a more integrated solution.

Configure Prometheus:

Ensure Prometheus is scraping metrics from the Kubernetes API and your applications.

Example prometheus.yaml configuration for scraping metrics:

```yaml

scrape_configs:
  - job_name: 'kubernetes-cadvisor'
    kubernetes_sd_configs:
      - role: node
    relabel_configs:
      - source_labels: [__address__]
        target_label: instance
```
Access Prometheus:

Expose Prometheus via a Kubernetes Service or use Port Forwarding to access the web UI:

```sh
kubectl port-forward svc/prometheus-server 9090:9090
```
2.4 Grafana
Grafana is a powerful tool for visualizing time-series data from InfluxDB, Prometheus, and other sources.

Setup Steps:

Install Grafana:

Deploy Grafana using Helm:

```sh
helm install grafana grafana/grafana
```
Configure Data Sources:

Add InfluxDB or Prometheus as data sources in Grafana for visualizing metrics.
Create Dashboards:

Use Grafana’s dashboard templates or create custom dashboards to visualize metrics.