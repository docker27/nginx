#!/bin/bash

downloan_url='http://nginx.org/packages/mainline/centos/7/x86_64/RPMS/nginx-1.13.12-1.el7_4.ngx.x86_64.rpm'
downloan_file_name='nginx-1.13.12-1.el7_4.ngx.x86_64.rpm'
nginx_md5='437f9fd29c8965fa0e71f20203ed973d';


function _init() {
	yum -y install openssl
	mkdir -p /opt/nginx/logs /opt/nginx/pids/ /etc/nginx/server.d/ /etc/nginx/upstream.d
        #touch /opt/nginx/logs/error.log /opt/nginx/logs/access.log /opt/nginx/pids/nginx.pid
}

function _install() {
	if [ ! -f /opt/install/${downloan_file_name} ]; then
                echo "nginx rpm not exist !!!"
                exit -1;
        fi

	md5=`md5sum /opt/install/${downloan_file_name} | awk -F ' ' '{print $1}'`
        if [ $md5 != $nginx_md5 ]; then
        	echo "nginx rpm md5 incorrect !!!"
                exit -1
        fi

	nginx_is_install=`rpm -qa | grep nginx |wc -l`
	if [ $nginx_is_install == 0 ];then
		rpm -ivh /opt/install/${downloan_file_name}
	fi

	cp /opt/install/nginx.conf /etc/nginx/nginx.conf

#	cp /opt/install/server_admin.souyidai.com.conf /etc/nginx/server.d/
#	cp /opt/install/upstream_jenkins.conf /etc/nginx/upstream.d/
#	cp /opt/install/upstream_nexus.conf /etc/nginx/upstream.d/
	echo 'nginx install success !!!'
}

# start
function _start() {
	/usr/sbin/nginx
	echo "start nginx success !!!"
}

# chkconfig
function _chkconfig() {
	cd /etc/rc.d/init.d/
	rm -rf /etc/rc.d/init.d/nginx 
	touch /etc/rc.d/init.d/nginx
	chmod +x /etc/rc.d/init.d/nginx
	echo '#!/bin/bash' >> /etc/rc.d/init.d/nginx
	echo '# chkconfig: 12345 95 05' >> /etc/rc.d/init.d/nginx
	echo '/usr/sbin/nginx' >> /etc/rc.d/init.d/nginx
	chkconfig --add nginx
	echo "chkconfig add nginx success"
}

_init
_install
_start
_chkconfig
