variable "do_token" {}
variable "image" {
	default = "ubuntu-16-04-x64"
}

provider "digitalocean" {
	token = "${var.do_token}"
}

resource "digitalocean_droplet" "nomad_server" {
	image = "${var.image}"
	name = "nomad-server"
	region = "nyc2"
	size = "512mb"
	private_networking = true
	ssh_keys = [ "8303746" ]

	provisioner "remote-exec" {
		scripts = [ "nomad.sh" ]
	}

	provisioner "file" {
		source = "server.hcl"
		destination = "/etc/nomad/server.hcl"

		connection {
			type = "ssh"
			user = "root"
			agent = true
		}
	}
}

resource "digitalocean_droplet" "nomad_client" {
	image = "${var.image}"
	name = "nomad-client"
	region = "nyc2"
	size = "512mb"
	private_networking = true
	ssh_keys = [ "8303746" ]

	provisioner "remote-exec" {
		scripts = [ "nomad.sh" ]
	}

	provisioner "file" {
		content = "${data.template_file.client.rendered}"
		destination = "/etc/nomad/client.hcl"

		connection {
			type = "ssh"
			user = "root"
			agent = true
		}
	}
}

data "template_file" "client" {
	template = "${file("client.hcl")}"

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
