#!/bin/bash

# 创建用户组
groupadd dev
# 创建用户
useradd -g dev dev
# 修改密码
echo "123456" | passwd dev --stdin > /dev/null 2>&1
