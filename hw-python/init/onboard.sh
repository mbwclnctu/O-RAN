ip=$(kubectl get svc -n ricplt --field-selector metadata.name=service-ricplt-xapp-onboarder-http -o jsonpath="{.items[0].spec.clusterIP}")
echo $ip
export CHART_REPO_URL=http://$ip:8080
dms_cli onboard --config_file_path=config-file.json --shcema_file_path=schema.json
