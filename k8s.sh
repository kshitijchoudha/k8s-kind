cd /home/kchoudha/work/git/python-docker

docker build --tag python-docker:1.0.0 .
kind create cluster --config kind-example-config-linux.yaml 
kind load docker-image python-docker:1.0.0

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

kubectl wait deployment -n ingress-nginx ingress-nginx-controller --for condition=Available=True --timeout=120s

sleep 90

kubectl apply -f deployment.yaml

kubectl wait deployment -n default hello-python --for condition=Available=True --timeout=90s

kubectl get pods

kubectl get ingress

curl http://localhost/hello