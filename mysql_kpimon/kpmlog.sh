# This script is used to start the KPIMON xApp (ver. cherry)
# The deployed functions: KPIMON xApp

ip=$(kubectl get svc -n ricplt --field-selector metadata.name=r4-infrastructure-kong-proxy -o jsonpath="{.items[0].spec.clusterIP}")
echo $ip
# uninstall old xapps
curl --location --request DELETE "http://$ip:32080/appmgr/ric/v1/xapps/xappkpimontomysql"
sleep 1

# install xapps to appmgr
curl --location --request POST --data-binary @xappkpimontomysql-0.2.0.tgz http://$ip:32080/helmrepo/api/charts
sleep 1

# checking what have been on-boarded
curl --location --request GET "http://$ip:32080/onboard/api/v1/charts"

# install helm charts from appmgr
curl --location --request POST "http://$ip:32080/appmgr/ric/v1/xapps" --header 'Content-Type: application/json' --data-raw '{"xappName": "xappkpimontomysql"}'
sleep 10

# now check the running state of these xApps
kubectl get pods -n ricxapp

kpimon=$(kubectl get pod -l app=ricxapp-xappkpimontomysql -n ricxapp -o jsonpath="{.items[0].metadata.name}")

#kubectl exec -n ricxapp $kpimon cat /opt/kpimon.log
kubectl logs -n ricxapp $kpimon
#kubectl exec -n ricxapp $kpimon cat /opt/kpimon.log
echo $kpimon
