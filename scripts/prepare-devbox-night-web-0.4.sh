python infra/revert_vm.py --user $1 --password $2 --tenant TestingInfra --keystone_url http://172.18.124.201:5000/v2.0/ --instance_name murano-devbox-nightweb0.4 --snapshot_name devbox_ubuntu1204

sleep 20s
python infra/RabbitMQ.py -rabbitmq_url 172.18.124.203:55672 -rabbitmq_username guest -rabbitmq_password guest -username WebTest -password swordfish -vhostname WebTest
expect infra/deploy_vm_new.sh ubuntu 10.100.0.33 172.18.124.203 release-0.4 5672 False WebTest
