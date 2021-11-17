#cloud-config

package_update: true
package_upgrade: true

packages:
  - screen
  - rsync
  - git
# - curl
# no docker engine by default would need to add a custom repo
# - docker-engine
# Install Podman/Buildah/Skopeo
# - buildah
# - podman-docker
# - oci-systemd-hook 
# - oci-unmount
# - skopeo
  - python3
  - python36
  - python36-devel
  - python3-pip-wheel
  - gcc
  - gcc++
  - nodejs
  - gettext
  - device-mapper-persistent-data
  - lvm2
  - bzip
  - ansible
  - yum-utils

groups:
  - docker
system_info:
  default_user:
    groups: [docker]

runcmd:
  - dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  - dnf update -y
  - dnf install docker-ce docker-ce-cli containerd.io
  - cp /home/opc/daemon.json /etc/docker/daemon.json
  - systemctl enable docker
  - systemctl start docker
  - docker run -d --name registry --restart=always -p 4000:5000  -v registry:/var/lib/registry registry:2
  - alternatives --set python /usr/bin/python3
  - curl -L https://github.com/docker/compose/releases/download/v${docker_compose_version}/docker-compose-linux-aarch64 -o /usr/local/bin/docker-compose-linux-aarch64
  - chmod -x /usr/local/bin/docker-compose-linux-aarch64
  - ln -s /usr/local/bin/docker-compose-linux-aarch64 /usr/bin/docker-compose
  - docker-compose --version
  - pip3 install -U docker-compose
  - [ bash, /opt/awx_build.sh ]
  - echo 'OCI Ampere Ansible AWX Builder.' >> /etc/motd
