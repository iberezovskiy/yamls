python infra/revert_vm.py --user $1 --password $2 --tenant TestingInfra --keystone_url http://172.18.124.201:5000/v2.0/ --instance_name murano-demo-release-03 --snapshot_name devbox_ubuntu1204_old

python infra/RabbitMQ.py -rabbitmq_url 172.18.124.202:55673 -rabbitmq_username guest -rabbitmq_password guest -username Demo03 -password swordfish -vhostname Demo03

sleep 40s
ping -c 5 10.100.0.52

expect infra/deploy_vm_release03.sh ubuntu 10.100.0.52 172.18.124.202 release-0.3 5674 False Demo03
expect infra/configure_conductor.sh ubuntu 10.100.0.52
