
# This script is used to restart the RIC platform (ver. cherry)
# The deployed functions: E2-SIM, near-RT RIC

# undeployment
./undeploy-ric-platform

# remove the volume of influxdb
helm del --purge nfs-release-1
kubectl create ns ricinfra
helm install stable/nfs-server-provisioner --namespace ricinfra --name nfs-release-1
apt remove -y nfs-common

# reconstruct the volume of influxdb
kubectl patch storageclass nfs -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
apt install -y nfs-common

# deploy the near-RT RIC (cherry version)
./deploy-ric-platform -f ../RECIPE_EXAMPLE/PLATFORM/example_recipe_oran_cherry_release.yaml


sleep 60 # waiting for the RIC pods becoming stable

# install e2sim to helm
helm install --namespace ricplt ~/e2-interface/e2sim/e2sm_examples/kpm_e2sm/helm

# get ingress IP and the pod name of e2sim
e2sim=$(kubectl get pod -l app=e2simulator -n ricplt -o jsonpath="{.items[0].metadata.name}")
ip=$(kubectl get svc -n ricplt --field-selector metadata.name=service-ricplt-e2term-sctp-alpha -o jsonpath="{.items[0].spec.clusterIP}")
echo $e2sim
echo $ip

kong_ip=$(kubectl get svc -n ricplt --field-selector metadata.name=r4-infrastructure-kong-proxy -o jsonpath="{.items[0].spec.clusterIP}")
echo $kong_ip


sleep 30 # waiting for e2sim becoming stable

# exec the e2agent on e2sim
#kubectl exec -n ricplt $e2sim nohup kpm_sim $ip 36422 > e2sim.log 2>&1 &
kubectl exec -n ricplt $e2sim nohup kpm_sim $ip 36422 >/dev/null 2>&1 &

sleep 30 # waiting for the setup procedure of e2sim

# install the KPIMON xApp
curl -X POST --data-binary @xappkpimontomysql-0.2.0.tgz http://$kong_ip:32080/helmrepo/api/charts
curl --location --request POST "http://$kong_ip:32080/appmgr/ric/v1/xapps" --header 'Content-Type: application/json' --data-raw '{"xappName": "xappkpimontomysql"}'

sleep 30 #waiting for KPIMON becoming stable

kpimon=$(kubectl get pod -l app=ricxapp-xappkpimontomysql -n ricxapp -o jsonpath="{.items[0].metadata.name}")

sleep 10 # waiting for the messages from e2sim
kubectl exec -n ricxapp $kpimon cat /opt/kpimon.log


