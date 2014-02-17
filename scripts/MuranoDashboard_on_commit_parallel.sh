WORKSPACE=$1

rm -rf *.html *.xml 0/ 1/ 2/ 3/ 4/ 5/

#################################################################
cd boffin; sudo python setup.py install; cd ../webUI
rm -rf *.html *.xml 0/ 1/ 2/ 3/ 4/ 5/
python ../boffin/dirty_parallel.py -n 20 -s sanity_checks.txt --name Test --IP 10.100.0.4 -r $WORKSPACE/0 -t commit

cd $WORKSPACE
python -m robot.rebot -d 0/ --ReportBackground white:white:white --reporttitle Murano_Dashboard_Automated_Testing_Report -o output.xml 0/*/*.xml || true

python $WORKSPACE/infra/clear_murano_environment.py --user anastasia --password swordfish --tenant Anastasia --keystone_url http://172.18.124.202:5000/v2.0/ --murano_url=http://10.100.0.4:8082/ || true

#################################################################
cd webUI
python ../boffin/dirty_parallel.py -n 20 -s sanity_checks.txt --name Test.Test --runfailed $WORKSPACE/0/output.xml --IP 10.100.0.4 -r $WORKSPACE/1 -t commit

cd $WORKSPACE
python -m robot.rebot -d 1/ --ReportBackground white:white:white --name Test --reporttitle Murano_Dashboard_Automated_Testing_Report -o output.xml 1/*/*.xml || true

python $WORKSPACE/infra/clear_murano_environment.py --user anastasia --password swordfish --tenant Anastasia --keystone_url http://172.18.124.202:5000/v2.0/ --murano_url=http://10.100.0.4:8082/ || true

#################################################################
cd webUI
python ../boffin/dirty_parallel.py -n 20 -s sanity_checks.txt --name Test.Test --runfailed $WORKSPACE/1/output.xml --IP 10.100.0.4 -r $WORKSPACE/2 -t commit

cd $WORKSPACE
python -m robot.rebot -d 2/ --ReportBackground white:white:white --name Test --reporttitle Murano_Dashboard_Automated_Testing_Report -o output.xml 2/*/*.xml || true

python -m robot.rebot -d . --ReportBackground white:white:white --name Report --reporttitle Murano_Dashboard_Automated_Testing_Report -o output.xml */*.xml || true
