
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




