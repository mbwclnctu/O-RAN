e2sim=$(kubectl get pod -l app=e2simulator -n ricplt -o jsonpath="{.items[0].metadata.name}")
ip=$(kubectl get svc -n ricplt --field-selector metadata.name=service-ricplt-e2term-sctp-alpha -o jsonpath="{.items[0].spec.clusterIP}")
kubectl exec -n ricplt $e2sim pkill kpm_sim
kubectl exec -n ricplt $e2sim nohup kpm_sim $ip 36422 > e2sim.log 2>&1 &

