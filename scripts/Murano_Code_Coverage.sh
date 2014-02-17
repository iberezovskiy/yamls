WORKSPACE=$1

cd $WORKSPACE
sudo apt-get install -y python-twisted-web python2.7-dev
sudo pip install --quiet nosexcover
sudo pip install --quiet pylint mock mockfs
sudo rm -rf murano-api
sudo rm -rf murano-conductor
sudo rm -rf python-muranoclient

### Murano Conductor ###
cd $WORKSPACE
git clone https://github.com/stackforge/murano-conductor
cd murano-conductor
sudo sh setup.sh uninstall
sudo sh setup.sh install

echo "[report]" > .coveragerc
echo "omit = *common*, *openstack*" >> .coveragerc

nosetests --with-xunit --with-xcoverage --cover-package=muranoconductor --cover-erase


### Murano API Service ###
cd $WORKSPACE
git clone https://github.com/stackforge/murano-api
cd murano-api
sudo sh setup.sh uninstall
sudo sh setup.sh install

echo "[report]" > .coveragerc
echo "omit = *common*, *openstack*" >> .coveragerc

nosetests --with-xunit --with-xcoverage --cover-package=muranoapi --cover-erase


### Murano python API client ###
cd $WORKSPACE
git clone https://github.com/stackforge/python-muranoclient
cd python-muranoclient

echo "[report]" > .coveragerc
echo "omit = *common*, *openstack*" >> .coveragerc

nosetests --with-xunit --with-xcoverage --cover-package=muranoclient --cover-erase
