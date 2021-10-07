kubectl apply -f ../Grafana/grafana.yaml

kubectl port-forward svc/grafana -n istio-system 3002
