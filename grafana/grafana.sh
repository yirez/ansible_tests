#!/bin/sh
set -e
set -o pipefail


echo "**************************************" 
echo "Deploys grafana to k8s cluster"
echo "**************************************"
echo ""
echo ""


# Exit script after printing help
helpFunction()
{
   echo ""
   echo "Usage: $0 master_ip grafana.yaml_path"
   exit 1
}

# Begin script in case all parameters are correct
echo "master_ip: $1"

masternode_public_ip=$1
grafana_path=$2

# Print helpFunction in case parameters are empty
if [ -z "$masternode_public_ip" ] || [ -z "$grafana_path" ]
then
   echo "Missing parameters";
   helpFunction
fi

echo " "
echo "Deploy Grafana & prepare implicit volume folders"
echo "**************************************"
    ssh root@${masternode_public_ip} '
    mkdir /tmp/grafana || echo "grafana dir exists"
    mkdir /var/lib/grafana || echo "/var/lib/grafana dir exists"
    mkdir /etc/grafana || echo "/etc/grafana dir exists"
    mkdir /var/log/grafana || echo "/var/log/grafana dir exists"
'

    scp $grafana_path root@${masternode_public_ip}:/tmp/grafana/grafana.yaml
    ssh root@${masternode_public_ip} '
    cd /tmp
    echo $(kubectl apply -f /tmp/grafana/grafana.yaml)
'
