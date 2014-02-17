BUILD_NUMBER=$1

cd rest_api_tests/load_and_performance
rm -rf *.xml
sed -i "s/url = http:\/\/172.18.124.202:5000\/v2.0\//url = http:\/\/172.18.11.4:5000\/v2.0\//" config.ini
sed -i "s/user = sergey_demo_user/user = AutotestUser/" config.ini
sed -i "s/password = 111/password = swordfish/" config.ini
sed -i "s/tenant = ForTests/tenant = AutotestProject/" config.ini
sed -i "s/url = http:\/\/172.18.78.92:8082\/environments/url = http:\/\/10.100.0.34:8082\/environments/" TestSuite.conf
fl-run-bench test_rest.py TestSuite.mix_for_load_testing||:
fl-build-report --html --output-directory=html$BUILD_NUMBER result-bench.xml
