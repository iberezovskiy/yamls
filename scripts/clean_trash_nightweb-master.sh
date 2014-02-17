rm -rf ForTrash
mkdir ForTrash && cd ForTrash
git clone https://github.com/stackforge/murano-tests
cd murano-tests/infra
python CleanTrash.py -openstack_user WebTestUser -openstack_password swordfish -openstack_tenant WebTestProject -keystone_url http://172.18.124.203:5000/v2.0/ -murano_url http://10.100.0.58:8082 -neutron_url http://172.18.124.203:9696/ -heat_url http://172.18.124.203:8004/v1/72239681556748a3b9b74b44d081b84b -create_new_router True

cd ../../..
rm -rf ForTrash/
