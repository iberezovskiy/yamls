GERRIT_REFSPEC=$1
BUILD_NUMBER=$2

rm -rf *.html *.xml
rm -rf etc/tempest.conf
rm -rf murano-tests
git clone https://github.com/stackforge/murano-tests

# get new deployment script

expect murano-tests/infra/deploy_component_new.sh ubuntu 10.100.0.27 $GERRIT_REFSPEC murano-repository

rm -rf murano-tests
cp etc/tempest.conf.sample etc/tempest.conf
sed -i "s/uri = http:\/\/127.0.0.1:5000\/v2.0\//uri = http:\/\/172.18.124.203:5000\/v2.0\//" etc/tempest.conf
sed -i "s/admin_username = admin/admin_username = AutotestUser/" etc/tempest.conf
sed -i "s/admin_password = secret/admin_password = swordfish/" etc/tempest.conf
sed -i "s/admin_tenant_name = admin/admin_tenant_name = AutotestProject/" etc/tempest.conf
sed -i "s/murano_url = http:\/\/127.0.0.1:8082/murano_url = http:\/\/10.100.0.27:8082/" etc/tempest.conf
sed -i "s/murano_metadata = http:\/\/127.0.0.1:8084/murano_metadata = http:\/\/10.100.0.27:8084/" etc/tempest.conf
sed -i "s/murano = false/murano = true/" etc/tempest.conf
cd tempest/api/murano/
nosetests -s -v --with-xunit --xunit-file=../../../test_report$BUILD_NUMBER.xml test_murano_metadata.py
