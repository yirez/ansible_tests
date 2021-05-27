#!/bin/sh
set -e
set -o pipefail


echo "**************************************"
echo "Creates single node consul on given vm"
echo "**************************************"
echo ""
echo ""


# Exit script after printing help
helpFunction()
{
   echo ""
   echo "Usage: $0 target_ip"
   exit 1
}

# Begin script in case all parameters are correct
echo "target_ip: $1"

target_ip=$1

# Print helpFunction in case parameters are empty
if [ -z "$target_ip" ]
then
   echo "Missing parameters";
   helpFunction
fi

echo " "
echo "Install Consul"
echo "**************************************"
ssh root@${target_ip} '
   yum install -y yum-utils
   yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
   yum -y install consul
   consul -v
   mkdir /opt/consul-data || mkdir /opt/consul-logs
   consul agent -server -data-dir=/opt/consul-data -bootstrap
'
