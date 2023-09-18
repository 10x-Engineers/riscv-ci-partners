# Setting up Promtheus and Grafana

## What are Prometheus and Grafana

Prometheus is a tool for monitoring usage of memory, CPU etc. It takes queries as mathematical expressions (like SQL) and returns the interactive graphical usage stats. It collects data using `node_exporter`, which is used to get raw data from the compute instances

Grafana is used for creating dashboards in which there can be different panels containing the graphical statistics from Prometheus. Grafana dashboards are more interactive and user-friendly than Prometheus.  

## Setting up Node Exporters  

Node exporters are needed for prometheus to get data from the compute instances.  
Download pre-compiled tarball of node_exporters from [this](<https://prometheus.io/download/#node_exporter>) link and place the tarballs on compute instances.  

Once `node_exporter` tarball is downloaded, extract it using following command:

```shell
tar -xvf node_exporter-x.x.x.linux-amd64.tar.gz
```

Run `node_exporter` on compute instances using command below (which will run node_exporter on port 9100 by default):  

```shell
./node_exporter
```  

Follow this procedure on every compute instance which is desired to be monitored using Prometheus.  

_**Note:** Make sure that compute instances can be accessed in the machine in which prometheus is installed._

## Configuring Prometheus

Use [this](<https://prometheus.io/download/#prometheus>) link to get pre-compiled tarball of Prometheus.  

Once Prometheus is downloaded, extract it using following command:  

```shell
tar -xvf prometheus-x.xx.x.linux-amd.tar.gz
```

Now either configure `prometheus.yml` file or create another `yml` file which will include the addresses of node_exporters. Following is an example template for `yml` file:  

```output
global:
    scrape_interval: 15s

scrape_configs: 
- job_name: node
  static_configs: 
  - targets: ['node_exporter_ip1:node_exporter_port1']
  - targets: ['node_exporter_ip2:node_exporter_port2']
```

## Running Prometheus

Once prometheus is configured properly, use following command to run prometheus.

```shell
./prometheus
```

_Note: By default Prometheus looks for `prometheus.yml`, if you want to use some other file for configuration, you will need to specify explicitly with `--config.file` option._

## Running Grafana

Once Prometheus is up and running, Grafana can be used to create dashboards with graphical interface in various panels inside dashboards.  

Use [this](<https://grafana.com/grafana/download>) to get pre-compiled tarball of Grafana  

After Grafana is ready to be run, use following command to run Grafana:  

```shell
./grafana-server #By default it will run on port 3000
```  

The default username and password of Grafana will be `admin`.

Once Grafana is installed, a dashboard can be created to with multiple panels which will show data from Prometheus.  

## Reference links

<https://grafana.com/docs/grafana/latest/getting-started/get-started-grafana-prometheus/>
