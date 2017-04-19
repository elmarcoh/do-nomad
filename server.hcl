data_dir = "/var/lib/nomad"

advertise {
	http = "${server_address}"
	rpc = "${server_address}"
	serf = "${server_address}"
}

server {
	enabled = true
}

client {
	enabled = false
}
