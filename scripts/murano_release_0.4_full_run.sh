BUILD_NUMBER=$1

rm -rf *.html *.xml

rm -rf etc/tempest.conf
cp etc/tempest.conf.sample etc/tempest.conf
sed -i "s/uri = http:\/\/127.0.0.1:5000\/v2.0\//uri = http:\/\/172.18.124.203:5000\/v2.0\//" etc/tempest.conf
sed -i "s/admin_username = admin/admin_username = AutotestUser/" etc/tempest.conf
sed -i "s/admin_password = secret/admin_password = swordfish/" etc/tempest.conf
sed -i "s/admin_tenant_name = admin/admin_tenant_name = AutotestProject/" etc/tempest.conf
sed -i "s/murano_url = http:\/\/127.0.0.1:8082/murano_url = http:\/\/10.100.0.26:8082/" etc/tempest.conf
sed -i "s/murano_metadata = http:\/\/127.0.0.1:8084/murano_metadata = http:\/\/10.100.0.26:8084/" etc/tempest.conf
sed -i "s/murano = false/murano = true/" etc/tempest.conf

nosetests -s -v --with-xunit --xunit-file=test_report$BUILD_NUMBER.xml tempest/api/murano/test_murano_envs.py tempest/api/murano/test_murano_services.py tempest/api/murano/test_murano_sessions.py tempest/api/murano/test_murano_deploy.py:SanityMuranoTest.test_create_and_deploying_linux_telnet tempest/api/murano/test_murano_deploy.py:SanityMuranoTest.test_create_and_deploying_linux_apache tempest/api/murano/test_murano_deploy.py:SanityMuranoTest.test_create_and_deploying_demo_service tempest/api/murano/test_murano_deploy.py:SanityMuranoTest.test_create_and_deploying_ad tempest/api/murano/test_murano_deploy.py:SanityMuranoTest.test_create_and_deploying_iis tempest/api/murano/test_murano_deploy.py:SanityMuranoTest.test_create_and_deploying_apsnet tempest/api/murano/test_murano_deploy.py:SanityMuranoTest.test_create_and_deploying_sql
