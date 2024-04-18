oci

# </ Oracle >

```bash

# key
................................................................................
ls -al
mkdir .ssh
cd .ssh
ssh-keygen -b 2048 -t rsa -f demokey
ls
    demokey   demokey.pub
................................................................................

................................................................................
# create webserver instance
................................................................................
    Coneect webserver
ssh -i demokey opc@<public IP address>
................................................................................

```

## Setup

```bash
oci -v
oci setup config

## Keys
cat ~/.oci/oci_api_key.pem
cat ~/.oci/oci_api_key_public.pem

## Developer Services --> Kubernetes Clusters (OKE) --> oke_stgX_revamp_oke --> Access Cluster
oci ce cluster create-kubeconfig --cluster-id ocid1.cluste... --file $HOME/.kube/config --region eu-frankfurt-1 --token-version 2.0.0  --kube-endpoint PRIVATE_ENDPOINT

### Alias and AutoComplete .From kubernetesDocumentation/Cheats
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
alias k=kubectl
complete -o default -F __start_kubectl k

## Commands
k -n aero-agent-stage1 get pods
k -n aero-agent-stage1 logs aero-agent-credit-service-84c87458db-vmb6m
k -n aero-agent-stage1 logs aero-agent-credit-service-84c87458db-vmb6m -c ContainerName

```
