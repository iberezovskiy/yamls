WORKSPACE=$1

sudo rm -rf *.html *.xml *.png 0/ 1/ 2/

cd boffin; sudo python setup.py install; cd ../webUI
sudo rm -rf *.html *.xml *.png

sed -i "s/http:\/\/10.100.0.6\/horizon/http:\/\/10.100.0.58\/horizon/" Sanity_tests_0.4.txt
sed -i "s/http:\/\/10.100.0.6\/horizon/http:\/\/10.100.0.58\/horizon/" Deploy_0.4.txt
#sed -i "s/http:\/\/10.100.0.6\/horizon/http:\/\/10.100.0.58\/horizon/" Coverage_of_bugs_0.4.txt
sed -i "s/http:\/\/10.100.0.6\/horizon/http:\/\/10.100.0.58\/horizon/" Murano_Repository_0.4.txt
sed -i "s/http:\/\/10.100.0.6\/horizon/http:\/\/10.100.0.58\/horizon/" Fields_validation.txt

cd $WORKSPACE/webUI

python $WORKSPACE/infra/clear_murano_environment.py --user WebTestUser --password swordfish --tenant WebTestProject --keystone_url http://172.18.124.203:5000/v2.0/ --murano_url=http://10.100.0.58:8082/ || true

pybot --variable IP:10.100.0.58 --include night --outputdir $WORKSPACE/1 --reportbackground white:white:white Sanity_tests_0.4.txt Deploy_0.4.txt Murano_Repository_0.4.txt Fields_validation.txt || cp $WORKSPACE/1/*.png $WORKSPACE/ || true

python $WORKSPACE/infra/clear_murano_environment.py --user WebTestUser --password swordfish --tenant WebTestProject --keystone_url http://172.18.124.203:5000/v2.0/ --murano_url=http://10.100.0.58:8082/ || true

pybot --variable IP:10.100.0.58 --include night --outputdir $WORKSPACE/2 --reportbackground white:white:white --runfailed $WORKSPACE/1/output.xml Sanity_tests_0.4.txt Deploy_0.4.txt Murano_Repository_0.4.txt Fields_validation.txt || cp $WORKSPACE/2/*.png $WORKSPACE/ || true

cd $WORKSPACE
python infra/merge_robot_results.py 1/output.xml 2/output.xml
python -m robot.rebot -d . --ReportBackground white:white:white --reporttitle Murano_Dashboard_Automated_Testing_Report -o output.xml result.xml
