# Digitalocean nomad cluster

This is a set of terraform files that creates a [Nomad](https://www.nomadproject.io)
cluster on DigitalOcean.

The cluster currently consists of a _server_ and a _client_, the project is
mostly an experimient on container networking strategies and to better
understand nomad & hashicorp ecosystem, but I expect to add new stuff in the
future.

## Requirements

* Terraform

## Runnig

First you will need a DO token that you can get in the settings page of your
DO account

```bash
terraform apply
```

## Accessing consul UI

Consul only accepts connections from the private network, to be able
to access the very useful _consul UI_, a ssh tunnel can be used:

```
ssh -L 8500:localhost:8500 root@<server-public-ip> -i <ssh-key>
```

the `server-public-ip` can be obtained with `terraform show`

## Why DO?

Nothing in particular, I just happened to have an account with some credits
`¯\_(ツ)_/¯`

## ToDo

- Add consul
- Add hashifront
- Example project setup
- Use TF modules
