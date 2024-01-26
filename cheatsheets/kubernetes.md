k8s
# </ Kubernetes >

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

https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

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
#verbocity level -> more information about API call

```

## Services
1. Cluster IP
2. Node port
3. Load Balancer

https://kubernetes.io/docs/concepts/services-networking/service/

```bash
nano service.yml
kubectl apply -f service.yml
kubectl get svc 
curl -L http://192.168.49.2:30007/demo
kubectl edit svc python-django-sample-app
cat service.yml
```
<!-- 
apiVersion: v1
kind: Service
metadata:
  name: python-django-sample-app
spec:
  type: NodePort
  selector:
    app: sample-python-app
  ports:
    - port: 80
      # By default and for convenience, the `targetPort` is set to
      # the same value as the `port` field.
      targetPort: 8000
      # Optional field
      # By default and for convenience, the Kubernetes control plane
      # will allocate a port from a range (default: 30000-32767)
      nodePort: 30007
 -->


`sh <(curl -Ls https://kubeshark.co/install)`
`kubeshark tap`
