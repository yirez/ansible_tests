#!/bin/sh
set -e
set -o pipefail


echo "**************************************"  
echo "Modifies k8s cluster created via kubespray"
echo "Required: prom.yaml"
echo "**************************************"
echo ""
echo ""


# Exit script after printing help
helpFunction()
{
   echo ""
   echo "Usage: $0 masternode_public_ip prom.yml_path"
   exit 1
}

# Begin script in case all parameters are correct
echo "master: $1"

masternode_public_ip=$1
prom_path=$2

# Print helpFunction in case parameters are empty
if [ -z "$masternode_public_ip" ] || [ -z "$prom_path" ]
then
   echo "Missing parameters";
   helpFunction
fi

echo " "
echo "Cluster control"
echo "**************************************"
ssh root@${masternode_public_ip} '
echo $(kubectl config current-context)
echo $(kubectl get pod --all-namespaces | grep -i "flan")
mkdir /tmp/prom || echo "prom dir ready"
'

echo " "
echo "1.2,1,3,1.4 label node 2 and deploy prometheus+ingress to it"
echo "**************************************"
scp $2 root@${masternode_public_ip}:/tmp/prom/prom.yaml
ssh root@${masternode_public_ip} '
kubectl label node node2 purpose=monitoring
kubectl taint nodes node2 purpose=monitoring:NoSchedule
cd /tmp
echo $(kubectl apply -f /tmp/prom/prom.yaml)
'
