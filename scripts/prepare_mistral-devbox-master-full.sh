python infra/revert_vm.py --user $1 --password $2 --tenant TestingInfra --keystone_url http://172.18.124.201:5000/v2.0/ --instance_name mistral-devbox-master --snapshot_name mistral_devbox

sleep 40s

python infra/RabbitMQ.py -rabbitmq_url 172.18.124.203:55672 -rabbitmq_username guest -rabbitmq_password guest -username mistral-devbox -password swordfish -vhostname mistral-devbox

expect infra/deploy_mistral.sh ubuntu 10.100.0.47 172.18.124.203 master 5672 mistral-devbox
