# This script is used to restart xApps on the RIC platform (ver. cherry)
# The deployed functions: E2-SIM, KPIMON

# get ingress IP and the pod name of e2sim
e2sim=$(kubectl get pod -l app=e2simulator -n ricplt -o jsonpath="{.items[0].metadata.name}")
ip=$(kubectl get svc -n ricplt --field-selector metadata.name=service-ricplt-e2term-sctp-alpha -o jsonpath="{.items[0].spec.clusterIP}")
echo $e2sim
echo $ip

# stop the e2agent on e2sim
kubectl exec -n ricplt $e2sim pkill kpm_sim
sleep 5 

# remove KPIMON from helm
curl --location --request DELETE "http://$(hostname):32080/appmgr/ric/v1/xapps/xappkpimon"
sleep 30 # wait for terminating KPIMON

kubectl get pods -n ricxapp
# checking what have been on-boarded
curl --location --request GET "http://$(hostname):32080/onboard/api/v1/charts"
# should be: No resources found in ricxapp namespace.

# restart the functions on near-RT RIC,
# including: e2mgr, e2term, rmr, submgr
kubectl rollout restart deployment --namespace ricplt deployment-ricplt-e2mgr deployment-ricplt-e2term-alpha deployment-ricplt-rtmgr deployment-ricplt-submgr

