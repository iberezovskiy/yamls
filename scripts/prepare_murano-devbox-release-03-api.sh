python infra/revert_vm.py --user $1 --password $2 --tenant TestingInfra --keystone_url http://172.18.124.201:5000/v2.0/ --instance_name murano-devbox-release-03-api --snapshot_name devbox_ubuntu1204

sleep 20s

expect infra/deploy_vm_release03.sh ubuntu 10.100.0.5 172.18.124.202 release-0.3 5674 False Apioncommit
