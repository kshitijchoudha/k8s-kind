 
- build docker image `docker build --tag python-docker:1.0.0 .`
- Run docker image on host daemon(skip tp deploy on k8s) `docker run -d -p 3232:3232 python-docker:1.0.0` 

- create kind cluster `kind create cluster --config kind-example-config.yaml`

- push dcoker image to kind cluster `kind load docker-image python-docker:1.0.0`  (https://iximiuz.com/en/posts/kubernetes-kind-load-docker-image/)


- set up k8s dashboard admin and access dashboard - https://upcloud.com/community/tutorials/deploy-kubernetes-dashboard/

    - install dashboard `https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/`
    - create dashboard admin `kubectl apply -f dashboard-admin.yaml`
    - get secret `kubectl get secret -n kubernetes-dashboard $(kubectl get serviceaccount admin-user -n kubernetes-dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode`
    - start proxy `kubectl proxy`  (kill if already running, find process by `ps -ef | grep "kubectl proxy"`)
    - access dashboard http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

- deploy nginx ingress `kubectl apply -f nginx-ingress.yaml

- deploy service to cluster `kubectl apply -f deployment.yaml`
- test service `curl http://localhost:3232/hello`

Notes:
> - WSL is not working with ingress on port 80 (likely because port is occupied by docker desktop)
> - port forward to host `kubectl port-forward <python-service-pod-name> 3232:3232` and test with curl if ingress is not working
> - to change listening port make changes in kind-example-config.yaml and nginx-ingress.yaml
> - default file for nginx-ingress is here - https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml made local file to change port from 80

Todo
> - 
