#cloud-config

package_update: true
package_upgrade: true

packages:
  - screen
  - rsync
  - git
  - curl
  - docker-engine
  - python3
  - python3-pip
  - gcc
  - gcc++
  - nodejs
  - gettext
  - device-mapper-persistent-data
  - lvm2
  - bzip
  - ansible

groups:
  - docker
system_info:
  default_user:
    groups: [docker]

runcmd:
  - cp /home/opc/daemon.json /etc/docker/daemon.json
  - systemctl restart docker
  - alternatives --set python /usr/bin/python3
  - curl -L https://github.com/docker/compose/releases/download/v2.2.1/docker-compose-linux-aarch64 -o /usr/local/bin/docker-compose-linux-aarch64
  - chmod -x /usr/local/bin/docker-compose-linux-aarch64
  - ln -s /usr/local/bin/docker-compose-linux-aarch64 /usr/bin/docker-compose
  - docker-compose --version
  - pip3 install -U pip
  - pip3 install -U wheel
  - pip3 install -U docker-compose
  - git clone -b 19.3.0 https://github.com/ansible/awx.git /usr/local/src/awx
  - [ bash, cd /usr/local/src/awx && make docker-compose-build ]
  - [ bash, cd /usr/local/src/awx && make awx/projects docker-compose-sources ]
  - [ bash, cd /usr/local/src/awx && docker-compose -f tools/docker-compose/_sources/docker-compose.yml run --rm awx_1 make clean-ui ui-devel ]
  - [ bash, cd /usr/local/src/awx && docker-compose -f tools/docker-compose/_sources/docker-compose.yml up -d ]
  - echo 'OCI Ampere Ansible AWX Builder.' >> /etc/motd
  - echo '* CHECK_LOGS: docker logs -f tools_awx_1' >> /etc/motd
  - echo '* CHANGE_PASSWD: docker exec -ti tools_awx_1 awx-manage changepasswd admin' >> /etc/motd
