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

ssh root@$target_server <<EO_REMOTE

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
mkdir /opt/gitlab-test
export GITLAB_HOME=/srv/gitlab


if docker top gitlab-test
then
    echo "Gitlab already up"
else
cat >/opt/gitlab-test/docker-compose.yml <<FF
web:
  image: 'gitlab/gitlab-ee:latest'
  restart: always
  hostname: 'gitlab.test'
  environment:
    GITLAB_OMNIBUS_CONFIG: |
      external_url 'https://gitlab.test'
  ports:
    - '5444:80'
    - '443:443'
    - '55:22'
  volumes:
    - '/config:/etc/gitlab'
    - '/logs:/var/log/gitlab'
    - '/data:/var/opt/gitlab'

FF
fi

cd /opt/gitlab-test/ \
&& docker-compose up -d \
&& echo "Gitlab ready at ${target_server}"

EO_REMOTE
