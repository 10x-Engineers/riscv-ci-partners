# Integrating Prometheus with Grafana

Before starting to integrate Prometheus with Grafana make sure they are set up properly. See [this](/docs/Usage_Monitoring/Prometheus_Grafana.md) document for setting up Prometheus and Grafana as standalone tools.  

## Configuration in Prometheus

Make sure all the `node_exporter` are running properly and the compute instances are discoverable by prometheus. Use following command for checking if the instances are accessible:

```shell
telnet COMPUTE_INSTANCE_IP COMPUTE_INSTANCE_PORT
```

If you get following response, then it means there is something wrong with firewall of compute instances as they are not accessible.  

```shell
Name or service not known
```  

## Configuration in Grafana

Enter the grafana IP in browser and login with credentials.  

Use following steps to integrate Grafana with Prometheus and creating dashbaords in Grafana

- Go to Grafana settings
- Go to `Data sources` tab
- Click on `Add data source`
- In `HTTP` section, add IP of machine on which Prometheus is running along with the port on which Prometheus is hosted (it is recommended to host Prometheus on the machine where Grafana is hosted, in that case, Prometheus will be accessed using LAN IP).
- In `Type and version` section, select Prometheus from drop down menu and choose a version of Prometheus in the next field.
- Click on `Save and test`  

If everything goes right, then it will say `Data source is working`.  

## Creating a dashboard in Grafana

- For creating a dashboard, click on `Dashboards`
- Click on `New` and then `New Dashboard`
- Then add a panel inside the dashbaord
- If you know the mathemtical expressions (which are easier and more verbose) then select `Code` while creating the panels instead of `Builder`.

_**Note:** Be sure to save the dashbaord because otherwise, it will not make changes on its own and dashboard will be lost._
