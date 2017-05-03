data_dir = "/var/lib/nomad"

advertise {
	http = "$local_ip"
	rpc = "$local_ip"
	serf = "$local_ip"
}

server {
	enabled = true
	bootstrap_expect = 1
}
