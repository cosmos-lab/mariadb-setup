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
	--host)
		host="$2" shift 2
		;;
	--port)
		port="$2" shift 2
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

$baseDir/bin/mysql \
    -S $instanceDir/mysql.sock  \
    -h$host \
    -P$port \
    -u$user \
    -p$userpwd
