# Hello Cloud
An Azure experiment.

This project will form the basis of our of Azure reference implementations.

HelloCloud uses an H2 database with Spring Data JPA for persistence. This will be replaced with SQL Server.
Currently there is only a Swagger UI.

Terraform will be used to provision Azure resources.

Secrets need to be in a separate secret.tfvars file.

```
subscription_id = "XXX"
tenant_id = "XXX"
client_id = "XXX"
client_secret = "XXX"
ssh_key_data = "ssh-rsa XXX"

```

To run Terraform:

```
terraform apply \
-var-file="secret.ftvars"
```

