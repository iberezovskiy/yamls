GERRIT_REFSPEC=$1
BUILD_NUMBER=$2

git fetch https://review.openstack.org/stackforge/murano-tests refs/changes/79/73579/5 && git checkout FETCH_HEAD
sudo ntpdate pool.ntp.org

expect infra/deploy_component_new.sh ubuntu 10.100.0.57 $GERRIT_REFSPEC murano-dashboard

rm -rf muranodashboard-tests/screenshots

cd muranodashboard-tests/config

sed -i "s/horizon_url = http:\/\/127.0.0.1\/horizon/horizon_url = http:\/\/10.100.0.57\/horizon/" config_file.conf
sed -i "s/murano_url = http:\/\/127.0.0.1:8082/murano_url = http:\/\/10.100.0.57:8082/" config_file.conf
sed -i "s/keystone_url = http:\/\/127.0.0.1:5000\/v2.0\//keystone_url = http:\/\/172.18.124.203:5000\/v2.0\//" config_file.conf
sed -i "s/keypair_name = default_keypair/keypair_name = murano-lb-key/" config_file.conf
sed -i "s/asp_git_repository = git_repo_for_asp_app/asp_git_repository = git:\/\/github.com\/Mirantis\//" config_file.conf

cd ..
rm -rf .noseids

nosetests --exclude test_032_check_opportunity_to_toggle_service --with-xunit --xunit-file=test_report$BUILD_NUMBER.xml -s -v sanity_check.py --nologcapture --with-id|| expect ../infra/deploy_component_new.sh ubuntu 10.100.0.57 $GERRIT_REFSPEC murano-dashboard && nosetests --exclude test_032_check_opportunity_to_toggle_service --with-xunit --xunit-file=test_report$BUILD_NUMBER.xml -s -v sanity_check.py --nologcapture --failed
