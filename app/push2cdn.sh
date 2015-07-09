#!/usr/bin/env bash
###########################
# Example:
# 	push2cdn
# 		增量推送文件到cdn
# 	push2cdn -a 
# 		推送所有文件到cdn
# Usage:
#	-a 
#		推送所有文件
# 	-m <module> 
#		模块名
###########################
set -o errexit;
src=src_dir
fileNum=20; # 每次分发文件数:20
module='h5_sinaimg_m'; # 默认module
all=false;

# parse param
while test $# -gt 0; do
	case "$1" in 
		-a) all=true;;
		-m) module="$2"; shift;;
	esac;
	shift
done

function pushcdn(){
	curl -d module=$1 -d files="$2" -d pad="AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" "http://small-pool.sina.com.cn:8080/publish" -v 
}

# Create src_dir;
test -d $src_dir || mkdir -p $src_dir;

# pullRsync
filelist=`rsync -avzn --port=8705 10.13.130.60::$module $src_dir`;
pullRsync="rsync -avz --port=8705 10.13.130.60::$module $src_dir";
$pullRsync;

# diffcmd
declare -i i=0;
declare -i j=0;
if [[ "$all" = '-a' ]]; then
	cmd="find $src -type f ";
else
	cmd='printf "%s" $filelist';
fi

while read line; do 
	if [[ "$line" =~ ^[[:digit:]./[:alpha:]]+$ ]] && [[ -f "$src/$line" ]];then
		file="$src/$line";
		md5=`md5 $file | awk '{print $NF}'`;
		files+=`echo -ne "\n$file\t$md5"`
		let ++i;
		if [[ $i -eq $fileNum ]];then
			pushcdn $module "$files";
			i=0;
			files='';
		fi
	fi
done < <($cmd) ;
[[ -n "$files" ]] && pushcdn $module "$files";
