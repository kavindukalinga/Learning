# </ Kubernetes >

## Table of Contents

- [\</ Kubernetes \>](#-kubernetes-)
  - [Table of Contents](#table-of-contents)
  - [Getting Start](#getting-start)
  - [Running Pods](#running-pods)
  - [Deployment](#deployment)
  - [self healing](#self-healing)
  - [Services](#services)
  - [Ingress](#ingress)
  - [ConfigMap \& VolumeMounts](#configmap--volumemounts)
  - [Persistent Volumes](#persistent-volumes)
  - [Secrets](#secrets)
  - [Encrypting Secret at Rest](#encrypting-secret-at-rest)
  - [RBAC](#rbac)
  - [Service Accounts](#service-accounts)
  - [Monitoring](#monitoring)
  - [kubernetes upgrade](#kubernetes-upgrade)
  - [Backup and Restore](#backup-and-restore)
  - [Certificate Requests](#certificate-requests)
  - [Useful commands](#useful-commands)
  - [JSON PATH](#json-path)
  - [Self Tutorial](#self-tutorial)
  - [Openshift Sandbox](#openshift-sandbox)
  - [Udemy](#udemy)

## Getting Start

```bash
### Alias and AutoComplete .From kubernetesDocumentation/Cheats
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
alias k=kubectl
complete -o default -F __start_kubectl k
```

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

| NAME                              | READY | STATUS            | RESTARTS | AGE |
| --------------------------------- | ----- | ----------------- | -------- | --- |
| nginx-deployment-86dcfdf4c6-kp979 | 1/1   | Running           | 0        | 18m |
| nginx-deployment-86dcfdf4c6-rxgf7 | 1/1   | Running           | 0        | 18m |
| nginx-deployment-86dcfdf4c6-xnn8h | 1/1   | Running           | 0        | 18m |
| nginx-deployment-86dcfdf4c6-kp979 | 1/1   | Terminating       | 0        | 18m |
| nginx-deployment-86dcfdf4c6-nhfp6 | 0/1   | Pending           | 0        | 0s  |
| nginx-deployment-86dcfdf4c6-nhfp6 | 0/1   | Pending           | 0        | 0s  |
| nginx-deployment-86dcfdf4c6-nhfp6 | 0/1   | ContainerCreating | 0        | 0s  |
| nginx-deployment-86dcfdf4c6-kp979 | 0/1   | Terminating       | 0        | 18m |
| nginx-deployment-86dcfdf4c6-kp979 | 0/1   | Terminating       | 0        | 18m |
| nginx-deployment-86dcfdf4c6-kp979 | 0/1   | Terminating       | 0        | 18m |
| nginx-deployment-86dcfdf4c6-kp979 | 0/1   | Terminating       | 0        | 18m |
| nginx-deployment-86dcfdf4c6-nhfp6 | 1/1   | Running           | 0        | 1s  |

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

## Ingress
k apply -f _.yaml
    # apiVersion: networking.k8s.io/v1
    # kind: Ingress
    # metadata:
    #   annotations:
    #     nginx.ingress.kubernetes.io/rewrite-target: /
    #     nginx.ingress.kubernetes.io/ssl-redirect: "false"
    #   name: ingress-wear-watch
    #   namespace: app-space
    # spec:
    #   rules:
    #   - http:
    #       paths:
    #       - backend:
    #           service:
    #             name: wear-service
    #             port:
    #               number: 8080
    #         path: /wear
    #         pathType: Prefix
    #       - backend:
    #           service:
    #             name: video-service
    #             port:
    #               number: 8080
    #         path: /stream
    #         pathType: Prefix
    #       - backend:
    #           service:
    #             name: food-service
    #             port:
    #               number: 8080
    #         path: /eat
    #         pathType: Prefix

k create ingress ingress-pay -n critical-space --rule="/pay=pay-service:8282"
k edit ingress ingress-pay -n critical-space
    #   annotations:
    #     nginx.ingress.kubernetes.io/rewrite-target: /

#### From the scratch:

controlplane ~ ➜  k get deploy -A
# NAMESPACE     NAME              READY   UP-TO-DATE   AVAILABLE   AGE
# app-space     default-backend   1/1     1            1           25s
# app-space     webapp-video      1/1     1            1           26s
# app-space     webapp-wear       1/1     1            1           26s
# kube-system   coredns

kubectl create namespace ingress-nginx
kubectl create configmap ingress-nginx-controller --namespace ingress-nginx
kubectl create serviceaccount ingress-nginx --namespace ingress-nginx
kubectl create serviceaccount ingress-nginx-admission --namespace ingress-nginx
# create the Roles, RoleBindings, ClusterRoles, and ClusterRoleBindings for the ServiceAccount
k get roles -n ingress-nginx
# NAME                      CREATED AT
# ingress-nginx             2024-02-15T08:55:15Z
# ingress-nginx-admission   2024-02-15T08:55:15Z

k get rolebindings.rbac.authorization.k8s.io -n ingress-nginx
# NAME                      ROLE                           AGE
# ingress-nginx             Role/ingress-nginx             87s
# ingress-nginx-admission   Role/ingress-nginx-admission   87s

kubectl apply ingress-controller.yaml
    # apiVersion: apps/v1
    # kind: Deployment
    # metadata:
    #   labels:
    #     app.kubernetes.io/component: controller
    #     app.kubernetes.io/instance: ingress-nginx
    #     app.kubernetes.io/managed-by: Helm
    #     app.kubernetes.io/name: ingress-nginx
    #     app.kubernetes.io/part-of: ingress-nginx
    #     app.kubernetes.io/version: 1.1.2
    #     helm.sh/chart: ingress-nginx-4.0.18
    #   name: ingress-nginx-controller
    #   namespace: ingress-nginx
    # spec:
    #   minReadySeconds: 0
    #   revisionHistoryLimit: 10
    #   selector:
    #     matchLabels:
    #       app.kubernetes.io/component: controller
    #       app.kubernetes.io/instance: ingress-nginx
    #       app.kubernetes.io/name: ingress-nginx
    #   template:
    #     metadata:
    #       labels:
    #         app.kubernetes.io/component: controller
    #         app.kubernetes.io/instance: ingress-nginx
    #         app.kubernetes.io/name: ingress-nginx
    #     spec:
    #       containers:
    #       - args:
    #         - /nginx-ingress-controller
    #         - --publish-service=$(POD_NAMESPACE)/ingress-nginx-controller
    #         - --election-id=ingress-controller-leader
    #         - --watch-ingress-without-class=true
    #         - --default-backend-service=app-space/default-http-backend
    #         - --controller-class=k8s.io/ingress-nginx
    #         - --ingress-class=nginx
    #         - --configmap=$(POD_NAMESPACE)/ingress-nginx-controller
    #         - --validating-webhook=:8443
    #         - --validating-webhook-certificate=/usr/local/certificates/cert
    #         - --validating-webhook-key=/usr/local/certificates/key
    #         env:
    #         - name: POD_NAME
    #           valueFrom:
    #             fieldRef:
    #               fieldPath: metadata.name
    #         - name: POD_NAMESPACE
    #           valueFrom:
    #             fieldRef:
    #               fieldPath: metadata.namespace
    #         - name: LD_PRELOAD
    #           value: /usr/local/lib/libmimalloc.so
    #         image: registry.k8s.io/ingress-nginx/controller:v1.1.2@sha256:28b11ce69e57843de44e3db6413e98d09de0f6688e33d4bd384002a44f78405c
    #         imagePullPolicy: IfNotPresent
    #         lifecycle:
    #           preStop:
    #             exec:
    #               command:
    #               - /wait-shutdown
    #         livenessProbe:
    #           failureThreshold: 5
    #           httpGet:
    #             path: /healthz
    #             port: 10254
    #             scheme: HTTP
    #           initialDelaySeconds: 10
    #           periodSeconds: 10
    #           successThreshold: 1
    #           timeoutSeconds: 1
    #         name: controller
    #         ports:
    #         - name: http
    #           containerPort: 80
    #           protocol: TCP
    #         - containerPort: 443
    #           name: https
    #           protocol: TCP
    #         - containerPort: 8443
    #           name: webhook
    #           protocol: TCP
    #         readinessProbe:
    #           failureThreshold: 3
    #           httpGet:
    #             path: /healthz
    #             port: 10254
    #             scheme: HTTP
    #           initialDelaySeconds: 10
    #           periodSeconds: 10
    #           successThreshold: 1
    #           timeoutSeconds: 1
    #         resources:
    #           requests:
    #             cpu: 100m
    #             memory: 90Mi
    #         securityContext:
    #           allowPrivilegeEscalation: true
    #           capabilities:
    #             add:
    #             - NET_BIND_SERVICE
    #             drop:
    #             - ALL
    #           runAsUser: 101
    #         volumeMounts:
    #         - mountPath: /usr/local/certificates/
    #           name: webhook-cert
    #           readOnly: true
    #       dnsPolicy: ClusterFirst
    #       nodeSelector:
    #         kubernetes.io/os: linux
    #       serviceAccountName: ingress-nginx
    #       terminationGracePeriodSeconds: 300
    #       volumes:
    #       - name: webhook-cert
    #         secret:
    #           secretName: ingress-nginx-admission

    # ---

    # apiVersion: v1
    # kind: Service
    # metadata:
    #   creationTimestamp: null
    #   labels:
    #     app.kubernetes.io/component: controller
    #     app.kubernetes.io/instance: ingress-nginx
    #     app.kubernetes.io/managed-by: Helm
    #     app.kubernetes.io/name: ingress-nginx
    #     app.kubernetes.io/part-of: ingress-nginx
    #     app.kubernetes.io/version: 1.1.2
    #     helm.sh/chart: ingress-nginx-4.0.18
    #   name: ingress-nginx-controller
    #   namespace: ingress-nginx
    # spec:
    #   ports:
    #   - port: 80
    #     protocol: TCP
    #     targetPort: 80
    #     nodePort: 30080
    #   selector:
    #     app.kubernetes.io/component: controller
    #     app.kubernetes.io/instance: ingress-nginx
    #     app.kubernetes.io/name: ingress-nginx
    #   type: NodePort

kubectl apply -f ingress-resource.yaml
    # apiVersion: networking.k8s.io/v1
    # kind: Ingress
    # metadata:
    #   name: ingress-wear-watch
    #   namespace: app-space
    #   annotations:
    #     nginx.ingress.kubernetes.io/rewrite-target: /
    #     nginx.ingress.kubernetes.io/ssl-redirect: "false"
    # spec:
    #   rules:
    #   - http:
    #       paths:
    #       - path: /wear
    #         pathType: Prefix
    #         backend:
    #           service:
    #            name: wear-service
    #            port:
    #             number: 8080
    #       - path: /watch
    #         pathType: Prefix
    #         backend:
    #           service:
    #            name: video-service
    #            port:
    #             number: 8080


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

## Persistent Volumes

```bash
    # k apply -f _.yaml
    # apiVersion: v1
    # kind: Pod
    # metadata:
    #   name: webapp
    # spec:
    #   containers:
    #   - name: event-simulator
    #     image: kodekloud/event-simulator
    #     env:
    #     - name: LOG_HANDLERS
    #       value: file
    #     volumeMounts:
    #     - mountPath: /log
    #      name: log-volume
    #   volumes:
    #   - name: log-volume
    #     hostPath:
    #       # directory location on host
    #       path: /var/log/webapp
    #       # this field is optional
    #       type: Directory

## Persistent Volume
    # apiVersion: v1
    # kind: PersistentVolume
    # metadata:
    #   name: pv-log
    # spec:
    #   persistentVolumeReclaimPolicy: Retain
    #   accessModes:
    #     - ReadWriteMany
    #   capacity:
    #     storage: 100Mi
    #   hostPath:
    #     path: /pv/log
k get pv

## Persistent Volume Claim
    # kind: PersistentVolumeClaim
    # apiVersion: v1
    # metadata:
    #   name: claim-log-1
    # spec:
    #   accessModes:
    #     - ReadWriteMany
    #   resources:
    #     requests:
    #       storage: 50Mi

k get persistentvolumeclaims
kubectl get pv,pvc
kubectl replace --force -f _.yaml
    # apiVersion: v1
    # kind: Pod
    # metadata:
    #   name: webapp
    # spec:
    #   containers:
    #   - name: event-simulator
    #     image: kodekloud/event-simulator
    #     env:
    #     - name: LOG_HANDLERS
    #       value: file
    #     volumeMounts:
    #     - mountPath: /log
    #       name: log-volume
    #   volumes:
    #   - name: log-volume
    #     persistentVolumeClaim:
    #       claimName: claim-log-1


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

## Encrypting Secret at Rest

<https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/>

```bash
kubectl create secret generic my-secret --from-literal=key1=supersecret
k get secret
k describe secret my-secret
k get secret my-secret -o yaml
var/lib/minikube/certs/etcd
```

## RBAC

```bash

k get roles -A
kubectl describe rolebinding kube-proxy -n kube-system
k auth can-i get pods --as dev-user

# To create a Role:-
kubectl create role developer --namespace=default --verb=list,create,delete --resource=pods

# To create a RoleBinding:-
kubectl create rolebinding dev-user-binding --namespace=default --role=developer --user=dev-user
#OR
kubectl apply -f _.yaml
    # kind: Role
    # apiVersion: rbac.authorization.k8s.io/v1
    # metadata:
    #   namespace: default
    #   name: developer
    # rules:
    # - apiGroups: [""]
    #   resources: ["pods"]
    #   verbs: ["list", "create","delete"]

    # ---
    # kind: RoleBinding
    # apiVersion: rbac.authorization.k8s.io/v1
    # metadata:
    #   name: dev-user-binding
    # subjects:
    # - kind: User
    #   name: dev-user
    #   apiGroup: rbac.authorization.k8s.io
    # roleRef:
    #   kind: Role
    #   name: developer
    #   apiGroup: rbac.authorization.k8s.io

k auth can-i list pods --as dev-user  # >>> yes

## Cluster Roles & Cluster Role Bindings
k get clusterrole | wc -l
k get clusterrolebindings.rbac.authorization.k8s.io | wc -l
k api-resources

k create clusterrole storage-admin --resources=persistentvolumes,storageclasses --verb=list,create,get,watch
k create clusterrolebinding michelle-storage-admin --user=michelle --clusterrole=storage-admin

# OR
k apply -f _.yaml
    # ---
    # kind: ClusterRole
    # apiVersion: rbac.authorization.k8s.io/v1
    # metadata:
    #   name: storage-admin
    # rules:
    # - apiGroups: [""]
    #   resources: ["persistentvolumes"]
    #   verbs: ["get", "watch", "list", "create", "delete"]
    # - apiGroups: ["storage.k8s.io"]
    #   resources: ["storageclasses"]
    #   verbs: ["get", "watch", "list", "create", "delete"]

    # ---
    # kind: ClusterRoleBinding
    # apiVersion: rbac.authorization.k8s.io/v1
    # metadata:
    #   name: michelle-storage-admin
    # subjects:
    # - kind: User
    #   name: michelle
    #   apiGroup: rbac.authorization.k8s.io
    # roleRef:
    #   kind: ClusterRole
    #   name: storage-admin
    #   apiGroup: rbac.authorization.k8s.io
kubectl auth can-i list storageclasses --as michelle  # >>>yes

```

## Service Accounts

```bash
k apply -f _.yaml
    # apiVersion: apps/v1
    # kind: Deployment
    # metadata:
    #   name: web-dashboard
    # spec:
    #   progressDeadlineSeconds: 600
    #   replicas: 1
    #   selector:
    #     matchLabels:
    #       name: web-dashboard
    #   template:
    #     metadata:
    #       labels:
    #         name: web-dashboard
    #     spec:
    #       containers:
    #       - env:
    #         - name: PYTHONUNBUFFERED
    #           value: "1"
    #         image: gcr.io/kodekloud/customimage/my-kubernetes-dashboard
    #         imagePullPolicy: Always
    #         name: web-dashboard
    #         ports:
    #         - containerPort: 8080

kubectl create serviceaccount dashboard-sa

cat /var/rbac/dashboard-sa-role-binding.yaml
    # ---
    # kind: RoleBinding
    # apiVersion: rbac.authorization.k8s.io/v1
    # metadata:
    #   name: read-pods
    #   namespace: default
    # subjects:
    # - kind: ServiceAccount
    #   name: dashboard-sa # Name is case sensitive
    #   namespace: default
    # roleRef:
    #   kind: Role #this must be Role or ClusterRole
    #   name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
    #   apiGroup: rbac.authorization.k8s.io
cat /var/rbac/pod-reader-role.yaml
    # ---
    # kind: Role
    # apiVersion: rbac.authorization.k8s.io/v1
    # metadata:
    #   namespace: default
    #   name: pod-reader
    # rules:
    # - apiGroups:
    #   - ''
    #   resources:
    #   - pods
    #   verbs:
    #   - get
    #   - watch
    #   - list

kubectl create token dashboard-sa
kubectl set serviceaccount deploy/web-dashboard dashboard-sa
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

## kubernetes upgrade

```bash
## Control plane
kubectl drain controlplane --ignore-daemonsets
apt update
apt-get install kubeadm=1.27.0-00
kubeadm upgrade apply v1.27.0
# Note that the above steps can take a few minutes to complete.
apt-get install kubelet=1.27.0-00
systemctl daemon-reload
systemctl restart kubelet
kubectl uncordon controlplane

## Worker nodes
kubectl drain node01 --ignore-daemonsets
ssh node01
apt-get update
apt-get install kubeadm=1.27.0-00
kubeadm upgrade node
apt-get install kubelet=1.27.0-00
systemctl daemon-reload
systemctl restart kubelet
exit
kubectl uncordon node01

```

## Backup and Restore

```bash
## Backup snapshot
ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
snapshot save /opt/snapshot-pre-boot.db

## Restore snapshot
ETCDCTL_API=3 etcdctl  --data-dir /var/lib/etcd-from-backup \
snapshot restore /opt/snapshot-pre-boot.db

vim /etc/kubernetes/manifests/etcd.yaml
      # volumes:
      # - hostPath:
      #     path: /var/lib/etcd-from-backup
      #     type: DirectoryOrCreate
      #   name: etcd-data

watch "crictl ps | grep etcd"
```

## Certificate Requests

```bash
## csrrequest.yaml
  # apiVersion: certificates.k8s.io/v1
  # kind: CertificateSigningRequest
  # metadata:
  #   name: akshay
  # spec:
  #   groups:
  #   - system:authenticated
  #   request: <req in base 64>
  #   signerName: kubernetes.io/kube-apiserver-client
  #   usages:
  #   - client auth
kubectl apply -f csrrequest.yaml
kubectl get csr
kubectl certificate approve/deny akshay

```

## Useful commands

```bash
alias k="kubectl"kubectl describe pod kube-apiserver-controlplane -n kube-system
k auth can-i create deploy
kubectl describe pod kube-apiserver -n kube-system

kubectl exec -it sample-python-app-5894dd7f76-jbtrs -- /bin/bash
kubectl run -i --tty --rm --image=alpine --restart=Never -- sh
kubectl run nginx --image=nginx --dry-run=client -o yaml > nginx.yaml

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

## JSON PATH

```bash
echo "cat q2.json | jpath $.bus" > answer2.sh

# $ list at the beginning
cat q4.json | jpath $[1,3].model   # only give [3]
cat q4.json | jpath '$[1,3].model' # correct
cat q4.json | jpath '$[1,3]'.model # correct
cat q4.json | jpath '$[*]'  # correct
# But list in the middle works
cat q5.json | jpath $.car.wheels[1,3].model

# wild-card *
$.car.wheels[0].model
$.car.wheels[*].model
$.*.wheels[*].model
cat q4.json | jpath '$[*].model'

# If
cat q9.json | jpath '$.prizes[?(@.year == 2014)].laureates[*].firstname'
cat input.json | jpath '$[?(@=="In Ltd")]'

# List
cat input.json | jpath '$[-1:]'
cat input.json | jpath '$[-5:]'.age

# For k8s
cat input.json | jpath $.metadata.name

k get pods -o=jsonpath='{range .items[*]} {.metadata.name}{"\t"}{.status.podIP}{"\n"}{end}'
k get pods -o=custom-columns=Pod:.metadata.name,IP:.status.podIP
k get pods --sort-by=.status.podIP
```

## Self Tutorial

```bash
minikube start

### Alias and AutoComplete .From kubernetesDocumentation/Cheats
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
alias k=kubectl
complete -o default -F __start_kubectl k

# session 0:
k create deployment nginx-deployment --image=nginx
k describe deployment nginx-deployment
k describe pod nginx-deployment-6d6565499c-jrbpq
k scale deployment nginx-deployment --replicas=5
k scale deployment nginx-deployment --replicas=3
k expose deployment nginx-deployment --port=8080 --target-port=80
minikube ssh
k get pods -o=jsonpath='{range .items[*]} {.metadata.name}{"\t"}{.status.podIP}{"\n"}{end}'
k get pods -o=custom-columns=Pod:.metadata.name,IP:.status.podIP
k get pods --sort-by=.status.podIP

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
k delete all --all
```

## Openshift Sandbox

<https://developers.redhat.com/developer-sandbox/activities/learn-kubernetes-using-red-hat-developer-sandbox-openshift>

## Udemy

```bash
docker exec -it container_name_or_id /bin/bash
kubectl taint nodes node01 spray=mortein:NoSchedule
kubectl run nginx --image=nginx --dry-run=client -o yaml > nginx-pod.yaml
kubectl label node node01 color=blue
kubectl create secret generic db-secret --from-literal=DB_Host=sql01 --from-literal=DB_User=root --from-literal=DB_Password=password123

kubectl -n elastic-stack -it app -- cat /log/app.log  # app=pod name
```
