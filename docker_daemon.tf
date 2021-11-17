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

data "template_file" "awx_build_sh" {
  template = file("${path.module}/templates/awx_build.sh.tpl")
  vars = {
    public_ip = oci_core_instance.ampere_a1.0.public_ip
    awx_build_prefix = var.awx_build_prefix
    awx_version = var.awx_version
    awx_operator_version = var.awx_operator_version
  }
}

output "awx_build_sh" {
  value = data.template_file.awx_build_sh.rendered
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

  provisioner "file" {
    content = data.template_file.awx_build_sh.rendered
    destination = "/home/opc/awx_build.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /home/opc/awx_build.sh /opt/awx_build.sh",
      "sudo chmod 0777 /opt/awx_build.sh",
    ]
  }
}
