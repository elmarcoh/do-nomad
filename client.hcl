data_dir = "/var/lib/nomad"
bind_addr = "$local_ip"

advertise {
	http = "$local_ip"
	rpc = "$local_ip"
	serf = "$local_ip"
}

client {
	enabled = true
	servers = [ "${server_address}" ]
}
