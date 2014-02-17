# get new deployment script
git fetch https://tnurlygayanov@review.openstack.org/stackforge/murano-tests refs/changes/67/68067/4 && git checkout FETCH_HEAD

python infra/revert_vm.py --user $1 --password $2 --tenant TestingInfra --keystone_url http://172.18.124.201:5000/v2.0/ --instance_name murano-devbox-master-web --snapshot_name devbox_ubuntu1204

sleep 20s
python infra/RabbitMQ.py -rabbitmq_url 172.18.124.203:55672 -rabbitmq_username guest -rabbitmq_password guest -username murano-devbox-master-web -password swordfish -vhostname murano-devbox-master-web
expect infra/deploy_vm_new.sh ubuntu 10.100.0.57 172.18.124.203 master 5672 False murano-devbox-master-web
expect infra/configure_conductor.sh ubuntu 10.100.0.57
