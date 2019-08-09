#!/bin/bash

pid=`cat /opt/pid/nginx.pid`
if [ $pid != 0 ];then
	kill -HUP $pid
else 
	/usr/sbin/nginx	
fi