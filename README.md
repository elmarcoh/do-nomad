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

## Why DO?

Nothing in particular, I just happened to have an account with some credits
`¯\_(ツ)_/¯`
