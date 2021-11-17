data "template_file" "docker_daemon_json" {
  template = file("${path.module}/templates/docker-daemon.json.tpl")
  vars = {
    public_ip = oci_core_instance.ampere_a1.0.public_ip
  }
}

output "docker_daemon_json" {
  value = data.template_file.docker_daemon_json.rendered
}

resource "local_file" "docker_daemon_json" {
  content = data.template_file.docker_daemon_json.rendered
  filename = "${path.module}/docker_registry-daemon.json"
}

resource "null_resource" "configure_docker" {
  triggers = {
    instance_public_ip = oci_core_instance.ampere_a1.0.public_ip
    template_content = data.template_file.docker_daemon_json.rendered
  }
  connection {
    type        = "ssh"
    host        = oci_core_instance.ampere_a1.0.public_ip
    user        = "opc"
    private_key = tls_private_key.oci.private_key_pem
  }

  provisioner "file" {
    content = data.template_file.docker_daemon_json.rendered
    destination = "/home/opc/daemon.json"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir /opt/kolla-build",
      "sudo mv /home/ubuntu/kolla_build.sh /opt/kolla-build/",
      "sudo chmod 0777 /opt/kolla-build/kolla_build.sh",
    ]
  }
}
