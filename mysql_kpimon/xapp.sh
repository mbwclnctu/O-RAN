#hostname=192.168.122.233
#hostname=10.111.48.73

# uninstall old xapps
curl --location --request DELETE "http://$(hostname):32080/appmgr/ric/v1/xapps/hw-python"

# checking what have been on-boarded
curl --location --request GET "http://$(hostname):32080/onboard/api/v1/charts"

# install helm charts from appmgr
curl --location --request POST "http://$(hostname):32080/appmgr/ric/v1/xapps"      --header 'Content-Type: application/json' --data-raw '{"xappName": "hw-python"}'
# now check the running state of these xApps
kubectl get pods -n ricxapp
