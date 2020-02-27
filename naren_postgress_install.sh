sudo su 
yum install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm -y
yum install postgresql10-server postgresql10-contrib -y
/usr/pgsql-10/bin/postgresql-10-setup initdb
vi /var/lib/pgsql/10/data/pg_hba.conf
# replace peer to trust and idnet to md5 
====================
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
# Allow replication connections from localhost, by a user with the
# replication privilege.
local   replication     all                                     trust
host    replication     all             127.0.0.1/32            md5
host    replication     all             ::1/128                 md5

====================

systemctl start postgresql-10
systemctl enable postgresql-10
sudo -u postgres /usr/pgsql-10/bin/psql -c "SELECT version();"
passwd postgres
# set new password 
=================================set up for sonar =================
su postgres
 psql
 create database sonarqubedb;
 create user sonarqube with encrypted password 'sonarqube@123';
 grant all privileges on database sonarqubedb to sonarqube;
 \q
exit










