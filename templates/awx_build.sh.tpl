#!/usr/bin/env bash
LOGFILE=/opt/build_awx_${awx_version}.log
exec >> $LOGFILE 2>&1
git clone -b ${awx_version} https://github.com/ansible/awx.git /opt/awx
cd /opt/awx
ansible-playbook tools/ansible/build.yml -v -e awx_image=${public_ip}:4000/${awx_build_prefix}/awx
docker push ${public_ip}:4000/${awx_build_prefix}/awx:${awx_version}
LOGFILE=/opt/build_awx-operator_${awx_operator_version}.log
exec >> $LOGFILE 2>&1
git clone -b ${awx_operator_version} https://github.com/ansible/awx-operator.git /opt/awx-operator
cd /opt/awx-operator
docker build -t ${public_ip}:4000/${awx_build_prefix}/awx-operator:${awx_operator_version} -f build/Dockerfile .
docker push ${public_ip}:4000/${awx_build_prefix}/awx-operator:${awx_operator_version}
