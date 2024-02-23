# Helm

## Basic CMD

```bash
helm version
helm list -a
helm repo list
helm repo add [NAME] [URL] [flags]
helm repo add bitnami https://charts.bitnami.com/bitnami
helm search repo nginx
helm search repo --versions "nginx server"

kubectl config get-contexts
kubectl create ns web
kubectl config set-context --current --namespace=web

helm install nginx01 bitnami/nginx
```

## Commands

```bash
vim values.yaml 
	# service:
	# 	type: NodePort
helm install nginx01 --values values.yaml --set service.ports.http=8080 bitnami/nginx
# hierarchy: parentChart < subChart < --setCommand
# Refer ArtifactHub for keyWords

helm install nginx01 --dry-run --set service.ports.http=8080 bitnami/nginx

helm get notes nginx01
helm get manifest nginx01
helm history nginx01
helm rollback nginx01 1
helm uninstall nginx01 --keep-history

## Tips 
helm install bitnami/nginx --generate-name
helm install nginx01 -n apps bitnami/nginx --create-namespace
# uninstall release wii NOT remove the namespace

helm upgrade --install nginx01 --set service.ports.http=8080 bitnami/nginx
# Install IF not already exists

helm upgrade nginx01 --set image.registry=foobar bitnami/nginx --wait --timeout 10s
# Waiting 10s untill pods created or Fail


```

### Helm release statuses

```bash
pending-install 	| The manifests are ready but they weren’t sent to Kubernetes yet
deployed 			| The manifests were sent to Kubernetes and they were accepted
pending-upgrade 	| The upgrade manifests are ready but weren’t sent to Kubernetes yet
superseded 			| When a release is upgraded successfully
pending-rollback 	| When roll-back manifests are generated but they weren’t sent to Kubernetes yet
uninstalling 		| When the current (most recent) release is being uninstalled
uninstalled 		| If history is retained, the status of the last uninstalled release
failed 				| If Kubernetes rejects the manifests supplied by Helm during any operation
```

## HelmCharts

```bash
helm create myapp
tree myapp
helm install myapp01 myapp
k get pods 
k port-forward myapp01-nfjdifiue-jfin 8080:08
# >>> localhost:8080

helm package . # package .tgz
helm install myapp02 myapp-0.1.0.tgz

helm upgrade myapp02 . --values values.yaml


```


## HelloWorld

```bash
helm create helloworld
ls -lart
tree helloworld
	# helloworld
	# ├── charts
	# ├── Chart.yaml
	# ├── templates
	# │   ├── deployment.yaml
	# │   ├── _helpers.tpl
	# │   ├── hpa.yaml
	# │   ├── ingress.yaml
	# │   ├── NOTES.txt
	# │   ├── serviceaccount.yaml
	# │   ├── service.yaml
	# │   └── tests
	# │       └── test-connection.yaml
	# └── values.yaml

vim ./helloworld/values.yaml
		# Service:
		# 	type: NodePort

helm install myhelloworld helloworld
	# NAME: myhelloworld
	# LAST DEPLOYED: Tue Feb 20 15:01:26 2024
	# NAMESPACE: default
	# STATUS: deployed
	# REVISION: 1
	# NOTES:
	# 1. Get the application URL by running these commands:
	#   export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services myhelloworld)
	#   export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
	#   echo http://$NODE_IP:$NODE_PORT

helm list -a
	# NAME        	NAMESPACE	REVISION	UPDATED                                  	STATUS  	CHART             	APP VERSION   
	# myhelloworld	default  	1       	2024-02-20 15:01:26.029642032 +0530 +0530	deployed	helloworld-0.1.0  	1.16.0 

helm uninstall myhelloworld

```



```bash

(base) kkalinga@ISA-KKALINGA:~/Documents/Learning/hel1$ helm install app111 webapp1/

(base) kkalinga@ISA-KKALINGA:~/Documents/Learning/hel1$ helm upgrade app111 webapp1/ --values webapp1/values.yaml 

(base) kkalinga@ISA-KKALINGA:~/Documents/Learning/hel1$ helm uninstall app111 


```

https://www.youtube.com/watch?v=jUYNS90nq8U
