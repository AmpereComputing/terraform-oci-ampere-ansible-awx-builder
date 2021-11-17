#!/usr/bin/env bash
LOGFILE=/opt/terraform-oci-ampere-ansible-awx-builder.log
exec >> $LOGFILE 2>&1
cd /opt
git clone -b ${awx_version} https://github.com/ansible/awx.git
cd /opt/awx
ansible-playbook tools/ansible/build.yml -v -e awx_image=${public_ip}:4000/${awx_build_prefix}/awx
docker push ${public_ip}:4000/${awx_build_prefix}/awx:${awx_version}
git clone -b ${awx_operator_version} https://github.com/ansible/awx-operator.git
cd /opt/awx-operator
docker build -t ${public_ip}:4000/${awx_build_prefix}/awx-operator:${awx_version} -f build/Dockerfile .
docker push ${public_ip}:4000/${awx_build_prefix}/awx:${awx_version}
