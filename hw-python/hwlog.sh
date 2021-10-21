# This script is used to start the KPIMON xApp (ver. cherry)
# The deployed functions: KPIMON xApp


# uninstall old xapps
#curl --location --request DELETE "http://$(hostname):32080/appmgr/ric/v1/xapps/hw-python"
#sleep 1

# install xapps to appmgr
#curl --location --request POST --data-binary @xappkpimontomysql-0.2.0.tgz http://$(hostname):32080/helmrepo/api/charts
#sleep 1

# checking what have been on-boarded
#curl --location --request GET "http://$(hostname):32080/onboard/api/v1/charts"

# install helm charts from appmgr
#curl --location --request POST "http://$(hostname):32080/appmgr/ric/v1/xapps" --header 'Content-Type: application/json' --data-raw '{"xappName": "hw-python"}'
#sleep 10

# now check the running state of these xApps
kubectl get pods -n ricxapp

kpimon=$(kubectl get pod -l app=ricxapp-hw-python -n ricxapp -o jsonpath="{.items[0].metadata.name}")

#kubectl exec -n ricxapp $kpimon cat /opt/kpimon.log
kubectl logs -n ricxapp $kpimon
#kubectl exec -n ricxapp $kpimon cat /opt/kpimon.log
echo $kpimon
