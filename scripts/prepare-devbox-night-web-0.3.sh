python infra/revert_vm.py --user $1 --password $2 --tenant TestingInfra --keystone_url http://172.18.124.201:5000/v2.0/ --instance_name murano-devbox-nightweb0.3 --snapshot_name devbox_ubuntu1204

sleep 20s
expect infra/deploy_vm.sh ubuntu 10.100.0.30 172.18.124.202 release-0.3 5674 False NightJob0.3
cd /usr/local/lib/python2.7/dist-packages/muranoconductor/commands
sudo sed -i "s/disable_rollback=False/disable_rollback=True/" cloud_formation.py
