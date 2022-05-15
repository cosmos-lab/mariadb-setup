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
    --rootpwd)
        rootpwd="$2" shift 2
        ;;
    --)
        break
        ;;
    esac
done

sudo $baseDir/bin/mysqladmin -uroot -p$rootpwd shutdown -S $instanceDir/mysql.sock
