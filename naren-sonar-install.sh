# install openJDK11
sudo su 
yum install java-11-openjdk-devel -y

cd /opt
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.1.0.31237.zip

unzip sonarqube-8.1.0.31237.zip

mv sonarqube-8.1.0.31237 /opt/sonarqube
groupadd sonarqube
useradd -g sonarqube sonarqube

chown sonarqube. /opt/sonarqube -R

mkdir -p /var/sonarqube/{temp,data}
chown sonarqube. /var/sonarqube -R

vi /opt/sonarqube/conf/sonar.properties
# ==============================
# sonar.jdbc.username=sonarqube
# sonar.jdbc.password=sonarqube@123
#sonar.jdbc.url=jdbc:postgresql://localhost/sonarqubedb

# sonar.web.javaOpts=-Xmx512m -Xms128m -XX:+HeapDumpOnOutOfMemoryError
# sonar.web.port=9000

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
# User=sonarqube
# Group=sonarqube
# Restart=always
# 
# [Install]
# WantedBy=multi-user.target
# ==========================================

systemctl daemon-reload
systemctl enable sonar
systemctl restart sonar.service
systemctl status sonar.service

# check the http:localhost:9000/

