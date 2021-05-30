#!/bin/sh
set -e
set -o pipefail


echo "**************************************"
echo "Deploys elastic and kibana to given server"
echo "**************************************"
echo ""
echo ""
 

# Exit script after printing help
helpFunction()
{
   echo ""
   echo "Usage: $0 target_server target_local_ip"
   exit 1
}

# Begin script in case all parameters are correct
echo "target_server: $1"
echo "target_local_ip: $2"

target_server=$1
server_ip=$2

# Print helpFunction in case parameters are empty
if [ -z "$target_server" ] || [ -z "$server_ip" ]
then
   echo "Missing parameters";
   helpFunction
fi

ssh root@$target_server <<EO_REMOTE
##TODO why doesn't these work, gets host ip
#server_ip=$(ip -4 addr show eth0 | awk '/inet/ {print $2}' | sed 's#/.*##')
#echo "$(who am i)   "

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
echo "Install Elastic (Also java if it does not exist)"
echo "**************************************"
mkdir /opt/elastic-test
echo "java home: ${JAVA_HOME}"
if [ -z "${JAVA_HOME}" ]
then
   echo "Missing Java, installing";
   yum install java-1.8.0-openjdk -y
fi

if docker top elastic-test
then
    echo "Elastic already up"
else
cat >/opt/elastic-test/docker-compose.yml <<FF
version: '3'
services:
  elastic-test:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.13.0
    container_name: elastic-test
    environment:
      - node.name=elastic-test
      - cluster.name=es-docker-cluster
      - cluster.initial_master_nodes=elastic-test
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - data01:/usr/share/elasticsearch/data
    ports:
      - 9200:9200
volumes:
  data01:
    driver: local
FF
fi


echo " "
echo "Setup kibana on compose"
echo "**************************************"
mkdir /opt/kibana-test

if docker top kibana-test
then
    echo "Kibana already up"
else
cat >/opt/kibana-test/docker-compose.yml <<FF
version: '3'
services:
  kibana-test:
    image: docker.elastic.co/kibana/kibana:7.13.0
    container_name: kibana-test
    ports:
      - 5601:5601
    environment:
      ELASTICSEARCH_URL: http://SERVERIP:9200
      ELASTICSEARCH_HOSTS: '["http://SERVERIP:9200"]'
    network_mode: host
FF
sed -i "s/SERVERIP/${server_ip}/" /opt/kibana-test/docker-compose.yml
fi

cd /opt/kibana-test/ \
&& docker-compose up -d \
&& cd /opt/elastic-test \
&& docker-compose up -d \
&& echo "Kibana ready at ${target_server}:5601" \
&& echo "Elastic ready at ${target_server}:9200"

EO_REMOTE
