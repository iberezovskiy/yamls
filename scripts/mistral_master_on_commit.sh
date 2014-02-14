GERRIT_REFSPEC=$1
BUILD_NUMBER=$2

rm -rf *.html *.xml
rm -rf etc/tempest.conf
rm -rf murano-tests
git clone https://github.com/stackforge/murano-tests
python murano-tests/infra/revert_vm.py --user tnurlygayanov --password AkvareL707! --tenant TestingInfra --keystone_url http://172.18.124.201:5000/v2.0/ --instance_name mistral-devbox-master-commit --snapshot_name mistral_devbox

sleep 40s

python murano-tests/infra/RabbitMQ.py -rabbitmq_url 172.18.124.203:55672 -rabbitmq_username guest -rabbitmq_password guest -username mistral-devbox-commit -password swordfish -vhostname mistral-devbox-commit

expect murano-tests/infra/deploy_mistral_commit.sh ubuntu 10.100.0.2 172.18.124.203 master 5672 mistral-devbox-commit $GERRIT_REFSPEC

rm -rf murano-tests
cp etc/tempest.conf.sample etc/tempest.conf
sed -i "s/uri = http:\/\/127.0.0.1:5000\/v2.0\//uri = http:\/\/172.18.124.203:5000\/v2.0\//" etc/tempest.conf
sed -i "s/admin_username = admin/admin_username = AutotestUser/" etc/tempest.conf
sed -i "s/admin_password = secret/admin_password = swordfish/" etc/tempest.conf
sed -i "s/admin_tenant_name = admin/admin_tenant_name = AutotestProject/" etc/tempest.conf
sed -i "s/mistral_url = http:\/\/127.0.0.1:8989/mistral_url = http:\/\/10.100.0.2:8989/" etc/tempest.conf
sed -i "s/mistral = false/mistral = true/" etc/tempest.conf

nosetests -s -v --with-xunit --xunit-file=test_report$BUILD_NUMBER.xml tempest/api/mistral/test_mistral_basic.py

