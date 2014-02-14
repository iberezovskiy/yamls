GERRIT_REFSPEC=$1
BUILD_NUMBER=$2

sudo ntpdate pool.ntp.org

expect infra/deploy_component_new.sh ubuntu 10.100.0.57 $GERRIT_REFSPEC murano-dashboard

git fetch https://review.openstack.org/stackforge/murano-tests refs/changes/79/73579/3 && git checkout FETCH_HEAD

rm -rf muranodashboard-tests/screenshots

cd muranodashboard-tests/config

sed -i "s/horizon_url = http:\/\/127.0.0.1\/horizon/horizon_url = http:\/\/10.100.0.57\/horizon/" config_file.conf
sed -i "s/murano_url = http:\/\/127.0.0.1:8082/murano_url = http:\/\/10.100.0.57:8082/" config_file.conf
sed -i "s/keystone_url = http:\/\/127.0.0.1:5000\/v2.0\//keystone_url = http:\/\/172.18.124.203:5000\/v2.0\//" config_file.conf
sed -i "s/keypair_name = default_keypair/keypair_name = murano-lb-key/" config_file.conf
sed -i "s/asp_git_repository = git_repo_for_asp_app/asp_git_repository = git:\/\/github.com\/Mirantis\//" config_file.conf

cd ..

nosetests --exclude test_check_opportunity_to_select_composed_service --with-xunit --xunit-file=test_report$BUILD_NUMBER.xml sanity_check.py -s -v sanity_check.py --nologcapture

#nosetests --exclude test_check_opportunity_to_select_composed_service -s -v --with-xunit --xunit-#file=test_report$BUILD_NUMBER.xml sanity_check.py --nologcapture --failed
