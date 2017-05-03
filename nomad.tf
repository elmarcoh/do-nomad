provider "digitalocean" {
	token = "${var.do_token}"
}

resource "digitalocean_droplet" "nomad_server" {
	image = "${var.image}"
	name = "nomad-server"
	region = "nyc2"
	size = "512mb"
	private_networking = true
	ssh_keys = [ "${var.ssh_key_id}" ]

	connection {
		type = "ssh"
		user = "root"
		private_key = "${file("do-rsa")}"
	}

	provisioner "remote-exec" {
		inline = [
			"mkdir /etc/nomad",
			"mkdir /etc/consul"
		]
	}

	provisioner "file" {
		source = "server.hcl"
		destination = "/etc/nomad/server.hcl"
	}

	provisioner "file" {
		source = "consul.service"
		destination = "/etc/systemd/system/consul.service"
	}

	provisioner "file" {
		source = "consul-bootstrap.json"
		destination = "/etc/consul/consul-bootstrap.json"
	}


	provisioner "remote-exec" {
		scripts = [ "install.sh" ]
	}
}

resource "digitalocean_droplet" "nomad_client" {
	image = "${var.image}"
	name = "nomad-client"
	region = "nyc2"
	size = "512mb"
	private_networking = true
	ssh_keys = [ "${var.ssh_key_id}" ]

	connection {
		type = "ssh"
		user = "root"
		private_key = "${file("do-rsa")}"
	}

	provisioner "remote-exec" {
		inline = [
			"mkdir /etc/nomad",
			"mkdir /etc/consul"
		]
	}

	provisioner "file" {
		source = "consul.service"
		destination = "/etc/systemd/system/consul.service"
	}

	provisioner "file" {
		content = "${data.template_file.consul-client.rendered}"
		destination = "/etc/consul/consul-client.json"
	}

	provisioner "file" {
		content = "${data.template_file.client.rendered}"
		destination = "/etc/nomad/client.hcl"
	}

	provisioner "remote-exec" {
		scripts = [ "install.sh" ]
	}
}

data "template_file" "client" {
	template = "${file("client.hcl")}"

	vars {
		server_address = "${digitalocean_droplet.nomad_server.ipv4_address_private}"
	}
}

data "template_file" "consul-client" {
	template = "${file("consul-client.json")}"

	vars {
		server_address = "${digitalocean_droplet.nomad_server.ipv4_address_private}"
	}
}

data "template_file" "server" {
	template = "${file("server.hcl")}"

	vars {
		server_address = "${digitalocean_droplet.nomad_server.ipv4_address_private}"
	}
}
