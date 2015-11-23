####################################################
# This script is used to install xhprof extension.
# Require: wget.
# Support: supports centos, fedora, redhat, macosx.
# Author: hilojack.com
####################################################
if ! php -m | grep xhprof > /dev/null; then
	cd ~;
	wget http://pecl.php.net/get/xhprof-0.9.4.tgz -O - | tar xzvf -
	cd xhprof-0.9.4/extension/
	phpize
	./configure
	make && sudo make install
	! [[ -d /opt/xhprof ]] && sudo mkdir -p /opt/xhprof;
	sudo chmod 777 /opt/xhprof/

	cat <<-MM | sudo tee -a $phpini

		[xhprof]
		extension = xhprof.so
		xhprof.output_dir = "/opt/xhprof"
	MM

	mv ~/xhprof-0.9.4/xhprof_lib/ /opt/xhprof/
	mv ~/xhprof-0.9.4/xhprof_html/ /opt/xhprof/
	#ownip=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
	nohup php -S 0.0.0.0:8000 -t /opt/xhprof/xhprof_html/ &
	sudo yum install graphviz -y || brew install graphviz; # xhprof's callgraph rely on graphviz
fi
