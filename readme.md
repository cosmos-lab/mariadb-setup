sh init.sh \
	-baseDir=mariadb-10.6.7-linux-systemd-x86_64  \
	-instanceDir=build/db-master \
	-config=deploy/my.cnf \
	-host=localhost \
	-port=3066 \
	-rootpwd=dbpwd \
	-user=dbuser \
	-userpwd=dbpwd 


sh start.sh \
	-baseDir=mariadb-10.6.7-linux-systemd-x86_64  \
	-instanceDir=build/db-master 

sh stop.sh \
	-baseDir=mariadb-10.6.7-linux-systemd-x86_64  \
	-instanceDir=build/db-master \
	-rootpwd=dbpwd 

sh console.sh \
	-baseDir=mariadb-10.6.7-linux-systemd-x86_64  \
	-instanceDir=build/db-master \
	-host=localhost \
	-port=3066 \
	-user=dbuser \
	-userpwd=dbpwd 


sh clean.sh \
-baseDir=mariadb-10.6.7-linux-systemd-x86_64  \
-instanceDir=build/db-master \
-rootpwd=dbpwd 


sudo apt-get install libncurses5


sudo lsof -i -P -n | grep LISTEN

pkill mariadbd