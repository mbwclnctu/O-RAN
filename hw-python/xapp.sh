#hostname=192.168.122.233
#hostname=10.111.48.73
kong_ip=$(kubectl get svc -n ricplt --field-selector metadata.name=r4-infrastructure-kong-proxy -o jsonpath="{.items[0].spec.clusterIP}")
echo $kong_ip

# uninstall old xapps
curl --location --request DELETE "http://$kong_ip:32080/appmgr/ric/v1/xapps/hw-python"

# checking what have been on-boarded
curl --location --request GET "http://$kong_ip:32080/onboard/api/v1/charts"

# install helm charts from appmgr
curl --location --request POST "http://$kong_ip:32080/appmgr/ric/v1/xapps"      --header 'Content-Type: application/json' --data-raw '{"xappName": "hw-python"}'
# now check the running state of these xApps
kubectl get pods -n ricxapp
hwpython=$(kubectl get pod -l app=ricxapp-hw-python -n ricxapp -o jsonpath="{.items[0].metadata.name}")
echo $hwpython
echo "kubectl exec -it -n ricxapp $hwpython bash"

