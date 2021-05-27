https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elastic-stack-on-centos-7

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

if grep -Fxq "elasticsearch" /etc/yum.repos.d/elasticsearch.repo
then
    echo "elastic repo exists"
else
    cat <<FF >>
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
FF

fi

yum install elasticsearch -y
vi /etc/elasticsearch/elasticsearch.yml \
&& systemctl start elasticsearch \
&& systemctl enable elasticsearch \
&& $(curl -X GET "localhost:9200")


yum install kibana -y \
&& systemctl enable kibana \
&& systemctl start kibana

yum install nginx -y

echo "kibanaadmin:`openssl passwd -apr1`" | sudo tee -a /etc/nginx/htpasswd.users

# server_name example.com www.example.com; server ip
vi /etc/nginx/conf.d/example.com.conf

nginx -t

systemctl restart nginx
setsebool httpd_can_network_connect 1 -P