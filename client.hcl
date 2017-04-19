data_dir = "/var/lib/nomad"

server {
	enabled = false
}

client {
	enabled = true
	servers = [ "${server_address}" ]
}
