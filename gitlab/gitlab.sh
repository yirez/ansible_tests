#!/bin/sh
set -e
set -o pipefail


echo "**************************************"  
echo "Deploys gitlab to a given server"
echo "**************************************"
echo ""
echo ""


# Exit script after printing help
helpFunction()
{
   echo ""
   echo "Usage: $0 target_server "
   exit 1
}

# Begin script in case all parameters are correct
echo "target_server: $1"

target_server=$1

# Print helpFunction in case parameters are empty
if [ -z "$target_server" ]
then
   echo "Missing parameters";
   helpFunction
fi

yum install epel-release -y
yum install jq -y
ssh root@$target_server <<EO_REMOTE

echo " "
echo "Install jq for json parsing "
echo "**************************************"
yum install epel-release -y
yum install jq -y


echo " "
echo "Ready Docker & Compose"
echo "**************************************"
yum install -y yum-utils \
&& yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo \
&& yum install docker-ce docker-ce-cli containerd.io -y \
&& systemctl start docker && systemctl enable docker \
&& yum install -y docker-compose \
&& echo "Docker & Compose installed"

echo " "
echo "Install gitlab "
echo "**************************************"
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash
sudo EXTERNAL_URL="http://${target_server}" yum install -y gitlab-ee



EO_REMOTE
