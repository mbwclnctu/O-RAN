# This script is used to restart xApps on the RIC platform (ver. cherry)
# The deployed functions: E2-SIM, KPIMON


# remove KPIMON from helm
curl --location --request DELETE "http://$(hostname):32080/appmgr/ric/v1/xapps/xappkpimon"
sleep 30 # wait for terminating KPIMON

kubectl get pods -n ricxapp
# checking what have been on-boarded
curl --location --request GET "http://$(hostname):32080/onboard/api/v1/charts"
# should be: No resources found in ricxapp namespace.


# onboard the KPIMON
curl --location --request POST "http://$(hostname):32080/appmgr/ric/v1/xapps" --header 'Content-Type: application/json' --data-raw '{"xappName": "xappkpimon"}'

sleep 40 #waiting for KPIMON becoming stable

kpimon=$(kubectl get pod -l app=ricxapp-xappkpimon -n ricxapp -o jsonpath="{.items[0].metadata.name}")
echo $kpimon
kubectl exec -n ricxapp $kpimon cat /opt/kpimon.log
