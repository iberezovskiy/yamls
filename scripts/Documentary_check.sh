WORKSPACE=$1

cd $WORKSPACE/boffin; sudo python setup.py install;
cd $WORKSPACE/documentation-tests

pybot --variable IP:10.100.0.10 --outputdir $WORKSPACE/1 --reportbackground white:white:white Documentation.txt || cp $WORKSPACE/1/*.png $WORKSPACE/ || true


pybot --variable IP:10.100.0.10  --outputdir $WORKSPACE/2 --reportbackground white:white:white --runfailed $WORKSPACE/1/output.xml Documentation.txt || cp $WORKSPACE/2/*.png $WORKSPACE/ || true

cd $WORKSPACE
python infra/merge_robot_results.py 1/output.xml 2/output.xml
python -m robot.rebot -d . --ReportBackground white:white:white --reporttitle Murano_Dashboard_Automated_Testing_Report -o output.xml result.xml

