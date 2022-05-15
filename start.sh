
ARGS=$(
	getopt -a --options : \
		--longoptions "baseDir:,instanceDir:" \
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
	--)
		break
		;;
	esac
done

echo "Starting server"
$baseDir/bin/mysqld_safe \
  --basedir=$baseDir \
  --datadir="$instanceDir/data" \
  --socket="$instanceDir/mysql.sock" &
