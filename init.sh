ARGS=$(
	getopt -a --options : \
		--longoptions "baseDir:,instanceDir:,config:,host:,port:,rootpwd:,user:,userpwd:" \
		-- "$@"
)
eval set -- "$ARGS"

while true; do
	case "$1" in
	--baseDir)
		baseDir="$2" shift 2
		;;
	--instanceDir)
		instanceDir="$2" shift 2
		;;
	--config)
		config="$2" shift 2
		;;
	--host)
		host="$2" shift 2
		;;
	--port)
		port="$2" shift 2
		;;
	--rootpwd)
		rootpwd="$2" shift 2
		;;
	--user)
		user="$2" shift 2
		;;
	--userpwd)
		userpwd="$2" shift 2
		;;
	--)
		break
		;;
	esac
done

CURRENTDIR=$(dirname "$(realpath $0)")
 
if [ ! -e $baseDir ]; then
  echo "baseDir - $baseDir not found!"
  exit 0
fi

if [ ! -e $instanceDir ]; then
  mkdir -p "$instanceDir/data"
fi

if [ ! -e $instanceDir ]; then
  echo "Can't create instanceDir - $instanceDir!"
  exit 0
fi

echo "Installing..."
$baseDir/scripts/mysql_install_db \
  --basedir=$baseDir \
  --defaults-file=$config \
  --datadir="$instanceDir/data" \
  --verbose=false

sh $CURRENTDIR/start.sh \
	-baseDir=$baseDir  \
	-instanceDir=$instanceDir

while !($baseDir/bin/mysqladmin --socket=$instanceDir/mysql.sock ping); do
  sleep 3
  echo "Waiting for mysql..."
done
echo "Running import queries"

sudo $baseDir/bin/mysql -S $instanceDir/mysql.sock -u root -e \
  "
  	ALTER USER 'root'@'localhost' IDENTIFIED BY '$rootpwd';
  	CREATE USER '$user'@'$host' IDENTIFIED BY '$userpwd';
  	GRANT ALL ON *.* TO '$user'@'$host' WITH GRANT OPTION;
  	FLUSH PRIVILEGES;
  "

