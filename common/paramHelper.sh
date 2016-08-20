#example for jjs 稍作修改即可作为一个简单的通用的获取参数的工具
#对一些简单的参数进行处理

#定义拦截器后缀
INTERCEPT=intercept
args=`getopt -o $params --long $site_names -- "$@"`
eval set -- "$args"

site_names=--${site_names//,/|--}
while true; do
	case "$1" in
		--js*)
			stack_name=${1:2}
			shift
			;;
		--mjs*)
			stack_name=${1:2}
			shift
			;;
		-[a-z])
			func=$1$INTERCEPT
                        type ${func:1} > /dev/null 2>&1
                        if [ $? -ne 0 ]; then
				eval ${params_map["$1"]}=$2
                        else
                                ${func:1} $1, $2
                        fi
			shift 2 
			;;

		--)
		shift
		break
		;;
	esac
done
