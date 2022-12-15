cd ~/work/git/python-docker

docker build --tag python-docker:1.0.0 .
kind create cluster --config kind-example-config-linux.yaml 
kind load docker-image python-docker:1.0.0

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
  
until echo "waiting for nginx"; sleep 5; curl http://localhost/ | grep "nginx"; do : ; done
sleep 60

kubectl apply -f deployment.yaml

kubectl wait deployment -n default hello-python --for condition=Available=True --timeout=90s

kubectl apply -f harness-delegate.yml

kubectl get pods

kubectl get ingress

sleep 15
curl http://localhost/hello