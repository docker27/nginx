FROM qianchun27/centos:7

MAINTAINER qianchun, qianchun27@hotmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV BASE_INSTALL_DIR /opt/install

RUN mkdir -p ${BASE_INSTALL_DIR}

COPY nginx.sh ${BASE_INSTALL_DIR}
COPY install.sh ${BASE_INSTALL_DIR}
COPY user.sh ${BASE_INSTALL_DIR}
COPY restart.sh ${BASE_INSTALL_DIR}

COPY nginx.conf ${BASE_INSTALL_DIR}

COPY server_admin.souyidai.com.conf ${BASE_INSTALL_DIR}

COPY upstream_jenkins.conf ${BASE_INSTALL_DIR}
COPY upstream_nexus.conf ${BASE_INSTALL_DIR}

COPY nginx-1.13.12-1.el7_4.ngx.x86_64.rpm  ${BASE_INSTALL_DIR}

RUN sh ${BASE_INSTALL_DIR}/install.sh
