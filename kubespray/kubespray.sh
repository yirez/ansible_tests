#!/bin/sh
set -e
set -o pipefail


echo "**************************************" 
echo "Creates k8s cluster using kubespray with a master node and worker node"
echo "**************************************"
echo ""
echo ""


# Exit script after printing help
helpFunction()
{
   echo ""
   echo "Usage: $0 masternode_public_ip workernode_public_ip cluster_name"
   exit 1
}

# Begin script in case all parameters are correct
echo "master: $1"
echo "node: $2"
echo "cluster name: $3"

masternode_public_ip=$1
workernode_public_ip=$2
cluster_name=$3

# Print helpFunction in case parameters are empty
if [ -z "$masternode_public_ip" ] || [ -z "$workernode_public_ip" ] || [ -z "$cluster_name" ]
then
   echo "Missing parameters";
   helpFunction
fi


echo " "
echo "Checking if /opt/${cluster_name} and .pem exist"
echo "**************************************"
if cd /opt/${cluster_name} && test -f /opt/${cluster_name}/Tycase.pem
then
   cd /opt/${cluster_name}
else
   echo "ERROR: Create a /opt/${cluster_name} folder with necessary server key file (.pem)"
   exit 1
fi


echo " "
echo "Grabbing kubespray from git repo"
echo "**************************************"
git clone https://github.com/kubernetes-sigs/kubespray.git \
&& cd kubespray \
&& cp /opt/${cluster_name}/Tycase.pem Tycase.pem

echo " "
echo "Adding ssh key"
echo "**************************************"
eval `ssh-agent -s` && chmod 400 /opt/${cluster_name}/*.pem && ssh-add -l |grep -q `ssh-keygen -lf /opt/${cluster_name}/*.pem  | awk '{print $2}'` || ssh-add /opt/${cluster_name}/*.pem


echo " "
echo "Installing kubespray requirements"
echo "**************************************"
cd /opt/${cluster_name}/kubespray
if pip3 install -r requirements.txt
then
   echo "kubespray requirements installed"
else
   yum �y install python3 && yum �y install python3-pip && pip3 install -r requirements.txt
fi

echo " "
echo "Copy inventory/sample to our cluster config folder"
echo "**************************************"
cp -rfp inventory/sample inventory/${cluster_name}

echo " "
echo "Update Ansible inventory file with inventory builder "
echo "**************************************"
declare -a IPS=(${masternode_public_ip} ${workernode_public_ip})
CONFIG_FILE=inventory/${cluster_name}/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

#TODO add sed to modify below files
echo " "
echo "Review and change parameters under inventory/$cluster_name"
echo "**************************************"
vi inventory/${cluster_name}/group_vars/all/all.yml \
&& vi inventory/${cluster_name}/group_vars/k8s_cluster/k8s-cluster.yml \
&& vi inventory/${cluster_name}/inventory.ini \
&& vi inventory/${cluster_name}/hosts.yaml

echo " "
echo "Run kubespray playbook"
echo "**************************************"
read -p "Ready? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# ansible-playbook -i inventory/${cluster_name}/hosts.yaml  --become --become-user=root cluster.yml
