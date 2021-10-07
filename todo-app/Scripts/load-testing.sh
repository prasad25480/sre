# Install Apache Beam (the load test)
sudo apt-get -y install apache2-utils

# Run the load test
ab -n 100000 -c 1000 http://34.102.242.26/
