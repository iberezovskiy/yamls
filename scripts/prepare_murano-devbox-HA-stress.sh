user_name=$1
password=$2

python infra/revert_vm.py --user $user_name --password $password --tenant TestingInfra --keystone_url http://172.18.124.201:5000/v2.0/ --instance_name murano-devbox-HA-1 --snapshot_name devbox_ubuntu1204

sleep 20s

python infra/revert_vm.py --user $user_name --password $password --tenant TestingInfra --keystone_url http://172.18.124.201:5000/v2.0/ --instance_name murano-devbox-HA-2 --snapshot_name devbox_ubuntu1204

sleep 20s

python infra/revert_vm.py --user $user_name --password $password --tenant TestingInfra --keystone_url http://172.18.124.201:5000/v2.0/ --instance_name murano-devbox-HA-3 --snapshot_name devbox_ubuntu1204

sleep 20s

expect infra/deploy_vm.sh ubuntu 10.100.0.35 172.18.11.4 release-0.4 5672 False A002box
expect infra/sql_HA_configure.sh ubuntu 10.100.0.35 10.100.0.34
expect infra/deploy_vm.sh ubuntu 10.100.0.36 172.18.11.4 release-0.4 5672 False A002box
expect infra/sql_HA_configure.sh ubuntu 10.100.0.36 10.100.0.34
expect infra/deploy_vm.sh ubuntu 10.100.0.37 172.18.11.4 release-0.4 5672 False A002box
expect infra/sql_HA_configure.sh ubuntu 10.100.0.37 10.100.0.34
