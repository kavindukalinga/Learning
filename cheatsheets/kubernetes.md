# </ Kubernetes >

## Getting Start

<https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/>

<https://minikube.sigs.k8s.io/docs/start/>

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start
kubectl version --client
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
kubectl get po -A
alias kubectl="minikube kubectl --"

kubectl get nodes
kubectl get po -A
```

## Running Pods

```bash
ls
touch pod.yml
nano pod.yml 
# apiVersion: v1
# kind: Pod
# metadata:
#     name: nginx
# spec:
#     containers:
#     - name: nginx
#       image: nginx:1.14.2
#       ports:
#       - containerPort: 80

kubectl create -f pod.yml
kubectl get pods
kubectl get all
kubectl get all -A
kubectl delete pods nginx

kubectl apply -f pod.yml
kubectl get pods -o wide
# Copy the ip address <10.224.0.0>
minikube ssh
 curl 10.244.0.0
 exit

kubectl get pods
kubectl logs nginx
kubectl describe pod nginx
kubectl delete pods nginx
```

## Deployment

<https://kubernetes.io/docs/concepts/workloads/controllers/deployment/>

```bash
touch deployment.yml
nano deployment.yml  # ctrl+X
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   name: nginx-deployment
#   labels:
#     app: nginx
# spec:
#   replicas: 3
#   selector:
#     matchLabels:
#       app: nginx
#   template:
#     metadata:
#       labels:
#         app: nginx
#     spec:
#       containers:
#       - name: nginx
#         image: nginx:1.14.2
#         ports:
#         - containerPort: 80

kubectl apply -f deployment.yml
# Auto creates deployment, replica set, pods
cat deployment.yml
```

## self healing

```bash
kubectl delete pods nginx-deployment-86dcfdf4c6-kp979
kkalinga@ISA-KKALINGA:~$ kubectl get pods -w
```

| NAME         |                       READY |  STATUS  |  RESTARTS |  AGE |
|------------|------------|----------|-------------|--------|
| nginx-deployment-86dcfdf4c6-kp979  | 1/1 |    Running  | 0        |  18m|
| nginx-deployment-86dcfdf4c6-rxgf7  | 1/1 |    Running  | 0         | 18m|
| nginx-deployment-86dcfdf4c6-xnn8h  | 1/1 |    Running   |0         | 18m|
| nginx-deployment-86dcfdf4c6-kp979  | 1/1 |    Terminating|   0      |    18m|
| nginx-deployment-86dcfdf4c6-nhfp6  | 0/1 |    Pending     |  0       |   0s|
| nginx-deployment-86dcfdf4c6-nhfp6  | 0/1 |    Pending      | 0        |  0s|
| nginx-deployment-86dcfdf4c6-nhfp6  | 0/1 |    ContainerCreating  | 0   |       0s|
| nginx-deployment-86dcfdf4c6-kp979  | 0/1 |    Terminating         |0    |      18m|
| nginx-deployment-86dcfdf4c6-kp979  | 0/1 |    Terminating     |    0     |     18m|
| nginx-deployment-86dcfdf4c6-kp979  | 0/1 |    Terminating      |   0      |    18m|
| nginx-deployment-86dcfdf4c6-kp979  | 0/1 |    Terminating       |  0       |   18m|
| nginx-deployment-86dcfdf4c6-nhfp6  | 1/1 |    Running            | 0        |  1s|

```bash
minikube status
kubectl get all
kubectl delete deploy nginx-deployment

kubectl get pods -v=7 #max=9
#verbosity level -> more information about API call

```

## Services

1. Cluster IP
2. Node port
3. Load Balancer

<https://kubernetes.io/docs/concepts/services-networking/service/>

```bash
nano service.yml
# apiVersion: v1
# kind: Service
# metadata:
#   name: python-django-sample-app
# spec:
#   type: NodePort
#   selector:
#     app: sample-python-app
#   ports:
#     - port: 80
#       # By default and for convenience, the `targetPort` is set to
#       # the same value as the `port` field.
#       targetPort: 8000
#       # Optional field
#       # By default and for convenience, the Kubernetes control plane
#       # will allocate a port from a range (default: 30000-32767)
#       nodePort: 30007

kubectl apply -f service.yml
kubectl get svc 
minikube ip
# http://192.168.49.2
# nodePort: 30007
curl -L http://192.168.49.2:30007/demo -v

sh <(curl -Ls https://kubeshark.co/install)
kubeshark tap

# LoadBalancer Type
kubectl edit svc python-django-sample-app

```

## Ingress

<https://kubernetes.io/docs/concepts/services-networking/ingress/>

```bash
nano ingress.yml
# apiVersion: networking.k8s.io/v1
# kind: Ingress
# metadata:
#   name: ingress-example
# spec:
#   rules:
#   - host: "foo.bar.com"
#     http:
#       paths:
#       - pathType: Prefix
#         path: "/bar"
#         backend:
#           service:
#             name: python-django-sample-app
#             port:
#               number: 80

kubectl apply -f ingress.yml
kubectl get ingress
# NAME              CLASS    HOSTS         ADDRESS   PORTS   AGE
# ingress-example   <none>   foo.bar.com             80      19s

minikube addons enable ingress
kubectl get pods -A | grep nginx
# ingress-nginx   ingress-nginx-admission-create-72bfr        0/1 Completed
# ingress-nginx   ingress-nginx-admission-patch-jv9rp         0/1 Completed
# ingress-nginx   ingress-nginx-controller-7c6974c4d8-4sgcx   1/1  Running

kubectl logs ingress-nginx-controller-7c6974c4d8-4sgcx -n ingress-nginx
# Namespace:"default", Name:"ingress-example", UID:"0273ed46-e68c-47c9-9b31-4088536d7612", APIVersion:"networking.k8s.io/v1", ResourceVersion:"47253", FieldPath:""}): type: 'Normal' reason: 'Sync' Scheduled for sync

kubectl get ingress
# NAME              CLASS    HOSTS         ADDRESS        PORTS   AGE
# ingress-example   <none>   foo.bar.com   192.168.49.2   80      23m

ping 192.158.49.2
ping foo.bar.com/bar
# For minikube:   $ sudo vim /etc/hosts
# foo.bar.com 192.168.49.2

```

## ConfigMap & VolumeMounts

```bash
kubectl get deploy
kubectl delete deploy sample-python-app
nano cm.yml
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   name: test-cm
# data:
#   db-port: "3306"

kubectl apply -f cm.yml
kubectl get cm
kubectl describe cm test-cm
nano deployment.yml
      # containers:
      # - name: python-app
      #   image: abhishekf5/python-sample-app-demo:v1
      #   env:
      #     - name: DB-PORT
      #       valueFrom:
      #         configMapKeyRef:
      #           name: test-cm
      #           key: db-port
      #   ports:
      #   - containerPort: 8000

kubectl apply -f deployment.yml
kubectl get pods
kubectl exec -it sample-python-app-5665875f56-2s5hs -- /bin/bash
  root@sample-python-app-5665875f56-2s5hs:/app# env | grep DB
  # >>> DB-PORT=3306

## Mount Volumes:
nano deployment.yml 
      # containers:
      # - name: python-app
      #   image: abhishekf5/python-sample-app-demo:v1
      #   volumeMounts:
      #     - name: db-connection
      #       mountPath: /opt
      #   ports:
      #   - containerPort: 8000
      # volumes:
      #   - name: db-connection
      #     configMap:
      #       name: test-cm

kubectl apply -f deployment.yml
kubectl get pods
kubectl exec -it sample-python-app-6c5b459cc9-4x954 -- /bin/bash
  root@sample-python-app-6c5b459cc9-4x954:/app# env | grep DB
  root@sample-python-app-6c5b459cc9-4x954:/app# ls /opt
  # db-port
  root@sample-python-app-6c5b459cc9-4x954:/app# cat /opt/db-port | more
  # 3306

nano cm.yml 
# data:
#   db-port: "3307"

kubectl apply -f cm.yml
kubectl get pods  # Pods have not restarted
kubectl exec -it sample-python-app-5894dd7f76-jbtrs -- cat /opt/db-port | more
  # 3307
```

## Secrets

```bash
kubectl create secret generic test-secret --from-literal=db-port="3306"
# Can do the .yml method as well
kubectl describe secret test-secret
# Data
# ====
# db-port:  4 bytes

kubectl edit secret test-secret
# apiVersion: v1
# data:
#   db-port: MzMwNg==
# kind: Secret
# metadata:
#   creationTimestamp: "2024-01-29T13:09:23Z"
#   name: test-secret
#   namespace: default
#   resourceVersion: "60704"
#   uid: 8d9fff7c-0707-4912-9e37-f92fadb63206
# type: Opaque

echo MzMwNg== | base64 --decode
# 3306
# ReadMore: How to encrypt etcd into secrets
```

## Monitoring

![Monitoring](monitoring.png)

```bash
## Install helm
# https://helm.sh/docs/intro/install/
helm version  # make sure version > 3.12

## add prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
# Try this twice: respond should be changed from "has been added" to "already exists"
helm repo update
helm install prometheus prometheus-community/prometheus # Read the text
kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-ext

helm list

kubectl get pods # takes some time
kubectl get svc
# prometheus-server-ext                 NodePort    10.108.102.49    <none>        80:30841/TCP   2s

minikube ip
# 192.168.49.2

# Visit from your browser: http://192.168.49.2:30841

## add Grafana
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana grafana/grafana
kubectl expose service grafana — type=NodePort — target-port=3000 — name=grafana-ext

# Add data source > prometheus > connection IP from ^ > build & test
# Home > Dashboards > Import Dashboards
# 3662: Dashboards:Prometheus 2.0 Overview    # i.e.
```

## Useful commands

```bash
alias k="kubectl"
kubectl exec -it sample-python-app-5894dd7f76-jbtrs -- /bin/bash
kubectl run -i --tty --rm --image=alpine --restart=Never -- sh

eval $(minikube -p minikube docker-env)

minikube start
minikube addons enable metrics-server
minikube dashboard

kubectl create deployment nginx --image=nginx --replicas=3
kubectl get python-django-sample-app
kubectl expose deployment nginx --port=8000 --target-port=80
kubectl get svc 
kubectl port-forward 

 minikube start
 minikube status
 minikube ssh
 kubectl cluster-info
 minikube ip
 kubectl get nodes
 kubectl get pods
 kubectl get namespaces
 kubectl get pods --namespace=kube-system
 kubectl run nginx --image=nginx
 kubectl get pods
 kubectl describe pod nginx

```

## Self Tutorial

```bash
minikube start
alias k="kubectl"

# session 0:
k create deployment nginx-deployment --image=nginx
k describe deployment nginx-deployment
k describe pod nginx-deployment-6d6565499c-jrbpq
k scale deployment nginx-deployment --replicas=5
k scale deployment nginx-deployment --replicas=3
k expose deployment nginx-deployment --port=8080 --target-port=80
minikube ssh

# session 1: custom image 
k create deployment kkdatapro --image=kavindukalinga/dataprocessing
k expose deployment kkdatapro --type=NodePort --port=5000
k get svc | grep kkdata
minikube service kkdatapro # direct to the website
minikube service kkdatapro --url # get the url

# session 2: version upgrade
k create deployment webapp11 --image=docker pull bstashchuk/k8s-web-hello
k scale deployment webapp11 --replicas=3
k expose deployment webapp11 --type=LoadBalancer --port=3000
minikube service webapp11
k set image deployment webapp11 k8s-web-hello=bstashchuk/k8s-web-hello:2.0.0
k rollout status deploy webapp11
```

## Openshift Sandbox

<https://developers.redhat.com/developer-sandbox/activities/learn-kubernetes-using-red-hat-developer-sandbox-openshift>
