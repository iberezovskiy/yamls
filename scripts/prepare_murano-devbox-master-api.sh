python infra/revert_vm.py --user $1 --password $2 --tenant TestingInfra --keystone_url http://172.18.124.201:5000/v2.0/ --instance_name murano-devbox-master-api --snapshot_name devbox_ubuntu1204

sleep 40s

python infra/RabbitMQ.py -rabbitmq_url 172.18.124.203:55672 -rabbitmq_username guest -rabbitmq_password guest -username murano-devbox-master-api -password swordfish -vhostname murano-devbox-master-api

expect infra/deploy_vm_new.sh ubuntu 10.100.0.55 172.18.124.203 master 5672 False murano-devbox-master-api
