cd ~
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64
sudo rm -rf murano-deployment
git clone https://github.com/stackforge/murano-deployment
sh murano-deployment/docs-builder/builder.sh
