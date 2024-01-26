k8s
# Kubernetes

## Getting Start

https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

https://minikube.sigs.k8s.io/docs/start/

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
```
<!-- 
apiVersion: v1
kind: Pod
metadata:
    name: nginx
spec:
    containers:
    - name: nginx
      image: nginx:1.14.2
      ports:
      - containerPort: 80

 -->
```bash
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
kubctl logs nginx
kubectl describe pod nginx
kubectl delete pods nginx
```


## Deployment
```bash
touch deployment.yml
nano deployment.yml  # ctrl+X
kubectl apply -f deployment.yml
# Auto creates deployment, replicat set, pods
cat deployment.yml
```
<!-- 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
 -->


## self healing
```bash
kubectl delete pods nginx-deployment-86dcfdf4c6-kp979
kkalinga@ISA-KKALINGA:~$ kubectl get pods -w
```
. NAME                                READY   STATUS    RESTARTS   AGE
. nginx-deployment-86dcfdf4c6-kp979   1/1     Running   0          18m
. nginx-deployment-86dcfdf4c6-rxgf7   1/1     Running   0          18m
. nginx-deployment-86dcfdf4c6-xnn8h   1/1     Running   0          18m
. nginx-deployment-86dcfdf4c6-kp979   1/1     Terminating   0          18m
. nginx-deployment-86dcfdf4c6-nhfp6   0/1     Pending       0          0s
. nginx-deployment-86dcfdf4c6-nhfp6   0/1     Pending       0          0s
. nginx-deployment-86dcfdf4c6-nhfp6   0/1     ContainerCreating   0          0s
. nginx-deployment-86dcfdf4c6-kp979   0/1     Terminating         0          18m
. nginx-deployment-86dcfdf4c6-kp979   0/1     Terminating         0          18m
. nginx-deployment-86dcfdf4c6-kp979   0/1     Terminating         0          18m
. nginx-deployment-86dcfdf4c6-kp979   0/1     Terminating         0          18m
. nginx-deployment-86dcfdf4c6-nhfp6   1/1     Running             0          1s



kubectl get rs
kubectl get all