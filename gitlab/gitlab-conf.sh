#!/bin/sh
set -e
set -o pipefail


echo "**************************************"
echo "Configures gitlab on a given server"
echo "**************************************"
echo ""
echo ""


# Exit script after printing help
helpFunction()
{
   echo ""
   echo "Usage: $0 target_server access_token"
   exit 1
}

# Begin script in case all parameters are correct
echo "target_server: $1 "
echo "access_token: received "

target_server=$1
access_token=$2
#TODO- get Authz from some other place
#curl --data "@auth.txt" --user client_id:client_secret --request POST "https:///oauth/token" | grep -i  "access_token"
#gitlab_rest_token=""


# Print helpFunction in case parameters are empty
if [ -z "$target_server" ] || [ -z "$access_token" ]
then
   echo "Missing parameters";
   helpFunction
fi


echo " "
echo "Create group"
echo "**************************************"

group_id=$(curl -s \
-H "Accept: application/json" \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-X POST --data '{
    "name":"test-ty-group",
    "path":"test-ty-group"
}' "http://${target_server}/api/v4/groups" --insecure | jq '.id')


echo "created group with id=${group_id}"

echo " "
echo "Create Project2"
echo "**************************************"

project_id_grafana=$(curl -s \
-H "Accept: application/json" \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-X POST --data '{
    "name":"ty-grafana",
    "path":"ty-grafana"
}' "http://${target_server}/api/v4/projects" --insecure | jq '.id')
echo "created project with id=${project_id_grafana}"

project_id_spring=$(curl -s \
-H "Accept: application/json" \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-X POST --data '{
    "name":"ty-spring",
    "path":"ty-project"
}' "http://${target_server}/api/v4/projects" --insecure | jq '.id')
echo "created project with id=${project_id_spring}"


echo " "
echo "Share Projects with group"
echo "**************************************"
curl -s \
-H "Accept: application/json" \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-X POST --data "{
    \"group_access\":\"40\",
    \"group_id\":\"${group_id}\",
    \"id\":\"${project_id_grafana}\"
}" "http://${target_server}/api/v4/projects/${project_id_grafana}/share" --insecure


curl -s \
-H "Accept: application/json" \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-X POST --data "{
    \"group_access\":\"40\",
    \"group_id\":\"${group_id}\",
    \"id\":\"${project_id_spring}\"
}" "http://${target_server}/api/v4/projects/${project_id_spring}/share" --insecure


echo " "
echo "Grab a runners token"
echo "**************************************"
runners_token_grafana=$(curl -s \
-H "Accept: application/json" \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-X GET  "http://${target_server}/api/v4/projects/${project_id_grafana}" --insecure | jq '.runners_token')
echo "grabbed runner token=${runners_token_grafana}"

runners_token_spring=$(curl -s \
-H "Accept: application/json" \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-X GET  "http://${target_server}/api/v4/projects/${project_id_spring}" --insecure | jq '.runners_token')
echo "grabbed runner token=${runners_token_spring}"


ssh root@$target_server <<EO_REMOTE

echo " "
echo "Start a runner"
echo "**************************************"
docker run -d --name gitlab-runner_grafana --restart always \
     -v /srv/gitlab-runner-grafana/config:/etc/gitlab-runner \
     -v /var/run/docker.sock:/var/run/docker.sock \
     gitlab/gitlab-runner:latest

docker run -d --name gitlab-runner_spring --restart always \
     -v /srv/gitlab-runner-spring/config:/etc/gitlab-runner \
     -v /var/run/docker.sock:/var/run/docker.sock \
     gitlab/gitlab-runner:latest

echo " "
echo "Register the runner"
echo "**************************************"
 docker run --rm -v /srv/gitlab-runner-grafana/config:/etc/gitlab-runner gitlab/gitlab-runner register \
  --non-interactive \
  --executor "docker" \
  --docker-image alpine:latest \
  --url "http://${target_server}/" \
  --registration-token "${runners_token_grafana}" \
  --description "docker-runner" \
  --tag-list "docker,tytest,grafana" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"

 docker run --rm -v /srv/gitlab-runner-grafana/config:/etc/gitlab-runner gitlab/gitlab-runner register \
  --non-interactive \
  --executor "docker" \
  --docker-image alpine:latest \
  --url "http://${target_server}/" \
  --registration-token "${runners_token_spring}" \
  --description "docker-runner" \
  --tag-list "docker,tytest,spring" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"

EO_REMOTE

echo " "
echo "Create User"
echo "**************************************"

user_id=$(curl -s \
-H "Accept: application/json" \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-X POST --data '{
    "name":"Yigit",
    "username":"sss",
    "email":"ssss@gmail.com",
    "password":"YOUR_PASS"
}' "http://${target_server}/api/v4/users" --insecure | jq '.id')
echo "created user with id=${user_id}"


echo " "
echo "Add new user to created project and group"
echo "**************************************"
curl -s \
-H "Accept: application/json" \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-X POST --data "{
    \"access_level\":\"40\",
    \"user_id\":\"${user_id}\",
    \"id\":\"${project_id_grafana}\"
}" "http://${target_server}/api/v4/projects/${project_id_grafana}/members" --insecure

curl -s \
-H "Accept: application/json" \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-X POST --data "{
    \"access_level\":\"40\",
    \"user_id\":\"${user_id}\",
    \"id\":\"${project_id_spring}\"
}" "http://${target_server}/api/v4/projects/${project_id_spring}/members" --insecure

curl -s \
-H "Accept: application/json" \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-X POST --data "{
    \"access_level\":\"40\",
    \"user_id\":\"${user_id}\",
    \"id\":\"${group_id}\"
}" "http://${target_server}/api/v4/groups/${group_id}/members" --insecure
