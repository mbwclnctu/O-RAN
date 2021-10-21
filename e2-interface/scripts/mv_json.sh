e2sim_pod=$(kubectl get pod -l app=e2simulator -n ricplt -o jsonpath="{.items[0].metadata.name}")
echo $e2sim_pod


kubectl cp -n ricplt /root/e2-interface/scripts/reports.json $e2sim_pod:/playpen/src/reports.json
