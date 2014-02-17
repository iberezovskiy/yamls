BUILD_NUMBER=$1

sudo ntpdate pool.ntp.org
rm -rf *.html *.xml

rm -rf etc/tempest.conf
cp etc/tempest.conf.sample etc/tempest.conf
sed -i "s/uri = http:\/\/127.0.0.1:5000\/v2.0\//uri = http:\/\/172.18.124.203:5000\/v2.0\//" etc/tempest.conf
sed -i "s/admin_username = admin/admin_username = AutotestUser/" etc/tempest.conf
sed -i "s/admin_password = secret/admin_password = swordfish/" etc/tempest.conf
sed -i "s/admin_tenant_name = admin/admin_tenant_name = AutotestProject/" etc/tempest.conf
sed -i "s/mistral_url = http:\/\/127.0.0.1:8989/mistral_url = http:\/\/10.100.0.47:8989/" etc/tempest.conf
sed -i "s/mistral = false/mistral = true/" etc/tempest.conf

nosetests -s -v --with-xunit --xunit-file=test_report$BUILD_NUMBER.xml tempest/api/mistral/test_mistral_basic.py 
