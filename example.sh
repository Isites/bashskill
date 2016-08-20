#设置对应数量的长选项（必须设置）
site_names="js,jsuk,jsfr,jsno,mjs"
#普通参数（必须设置,并且不要设置无参数选项，无参数选项尽量使用长选项替代）
params="s:a::"
#参数映射
params_map['-s']=stack_id
#如果不想直接赋值，可以定义如下函数进行拦截，实现自定义功能
aintercept(){
	echo ---${1}---
}

#使用工具, 再工具执行完毕之后$#,$@,$*等变量会恢复初始状态
source common/paramHelper.sh
#eval 这个命令有点绕，需要多理解
echo ${params_map['-s']}=`eval echo '$'"${params_map['-s']}"`
echo $stack_name
echo $stack_id
