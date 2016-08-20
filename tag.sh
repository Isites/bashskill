site_names="js,jsuk,jsfr,jsno,jsar,mjs,mjsuk,mjsfr,mjsno,mjsar"
params="v::"
params_map['-v']=version
display_usage(){
cat <<Usage
example:./tag.sh --js -v00|./tag.sh --js
--js|--jsfr|--jsno|--mjs etc.
Usage
}
if [ $# -eq 0 ]; then
	display_usage; exit 1;
fi

vintercept(){
	if [ -z "$1" ]; then
		version="00"
	else
		version=$1
	fi
	
}

stack_name=js
version=00


args=`getopt -o $params --long $site_names -- "$@"`
eval set -- "$args"
INTERCEPT=intercept
site_names=--${site_names//,/|--}
while true; do
	case "$1" in
		--js*)
			stack_name=${1:2}
			prefix=v0.1
			shift
			;;
		--mjs*)
			stack_name=${1:2}
			prefix=v0.2
			shift
			;;
		-[a-z])
			func=$1$INTERCEPT
                        type ${func:1} > /dev/null 2>&1
                        if [ $? -ne 0 ]; then
				eval ${params_map["$1"]}=$2
                        else
                                ${func:1} $2
                        fi
			shift 2 
			;;

		--)
		shift
		break
		;;
	esac
done


echo ${prefix}-$stack_name`date +%Y%m%d`$version


