BUILD_NUMBER=$1

cd rest_api_tests/load_and_performance/MetaTests
rm -rf *.xml
sed -i "s/url = http:\/\/172.18.11.4:5000\/v2.0\//url = http:\/\/172.18.124.203:5000\/v2.0\//" config.ini
sed -i "s/user = admin/user = AutotestUser/" config.ini
sed -i "s/tenant = admin/tenant = AutotestProject/" config.ini
sed -i "s/url = http:\/\/172.18.78.92:8082\/environments/url = http:\/\/10.100.0.26:8082\/environments/" TestMeta.conf
sed -i "s/meta_url = http:\/\/172.18.78.92:8084/meta_url = http:\/\/10.100.0.26:8084/" TestMeta.conf
fl-run-bench test_rest.py TestMeta.mix_for_load_testing||:
fl-build-report --html --output-directory=html$BUILD_NUMBER result-bench.xml
