# install openJDK11

sudo yum install java-11-openjdk-devel -y

cd /opt
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.1.0.31237.zip

unzip sonarqube-8.1.0.31237.zip

mv sonarqube-8.1.0.31237 /opt/sonarqube

useradd -Urs /bin/false sonarqube
chown sonarqube. /opt/sonarqube -R

mkdir -p /var/sonarqube/{temp,data}
chown sonarqube. /var/sonarqube -R

vi /opt/sonarqube/conf/sonar.properties
# ==============================
# sonar.jdbc.username=sonar
# sonar.jdbc.password=sonar@123

# sonar.web.javaOpts=-Xmx512m -Xms128m -XX:+HeapDumpOnOutOfMemoryError

# sonar.ce.javaOpts=-Xmx512m -Xms128m -XX:+HeapDumpOnOutOfMemoryError

# sonar.search.javaOpts=-Xmx512m -Xms512m -XX:+HeapDumpOnOutOfMemoryError

# sonar.path.data=/var/sonarqube/data
# sonar.path.temp=/var/sonarqube/temp
#======================================

sysctl -w vm.max_map_count=262144
sysctl -w fs.file-max=65536
ulimit -n 65536
ulimit -u 4096

# add the service

vi /etc/systemd/system/sonar.service
# ==========================================
# [Unit]
# Description=SonarQube
# After=syslog.target network.target
#
# [Service]
# Type=forking
#
# ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
# ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
# LimitNOFILE=65536
# LimitNPROC=4096
#
# User=sonar
# Group=sonar
# Restart=always
# 
# [Install]
# WantedBy=multi-user.target
# ==========================================

sudo systemctl daemon-reload
sudo systemctl enable sonar
sudo service sonar start
# check the http:localhost:9000/

