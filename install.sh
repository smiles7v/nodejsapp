#!/usr/bin/env bash
#sudo set -e
set +o posix

# update instance
sudo yum -y update

#set psql path
sqitch config --user engine.pg.client /usr/bin/psql

#install postgresql
#start postgresql daemon
sudo /sbin/chkconfig --levels 235 postgresql on
sudo service postgresql start
echo 'Database server started....'

echo 'Setting permission....'
cd /home/
sudo chmod -R 755 /home/ec2-user/
sudo cp pg_hba.conf /var/lib/pgsql9/data/pg_hba.conf

sudo service postgresql restart
echo 'Database server re-started....'

sudo -u postgres -H sh -c 'createdb nodejs; cd ~/customers/sql; sqitch deploy db:pg:nodejs'
echo 'Database deployed....'
