# Hello Cloud
An Azure experiment.

This project will form the basis of our of Azure reference implementations.

HelloCloud uses an H2 database with Spring Data JPA for persistence. This will be replaced with SQL Server.
Currently there is only a Swagger UI.

Terraform is used to provision Azure resources. Packer is used to build a VM image that incorporates the application binary.

For Terraform, secrets need to be in a separate secret.tfvars file. This file is not committed to Github.
A Service Principal needs to be created that will be used by both Terraform and Packer to Authenticate with Azure.

```
az login
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/YOUR_SUBSCRIPTION_ID"
```

Azure CLI will respond:

```
{
  "appId": "APP_ID",
  "displayName": "NAME",
  "name": "http://NAME",
  "password": "PASSWORD",
  "tenant": "TENNANT_ID"
}
```
Then add the credentials to secret.tfvars. An SSH key pair will also need to be created. The public key will need
to be added to the file. Note: Terraform / Azure does not support the uploading of SSH keys, it dynamically creates
a server-side key pair with a matching public key.

```
subscription_id = "YOUR_SUNSCRIPTION_ID"
tenant_id = "TENNANT_ID"
client_id = "APP_ID"
client_secret = "PASSWORD"
ssh_key_data = "ssh-rsa XXX"

```

To run Terraform the terraform scripts, the secret.tfvars needs to be passed as a -var parameter

This will initialized the Azure provider.
```
terraform init \
-var-file="secret.ftvars"
```

To plan 
```
terraform plan \
-var-file="secret.ftvars"
```

To apply 
```
terraform apply \
-var-file="secret.ftvars"
```

## Packer
Packer is used to embed application binaries and start scripts into a custom VM image.
To use, the Packer executable needs to be installed from https://www.packer.io/

Variables will need to be passed to Packer to run the script. Best thing to do is to create a script.
SSH password can be anything.

```
#!/usr/bin/env bash
packer build \
    -var 'client_id=APP_ID' \
    -var 'client_secret=PASSWORD' \
    -var 'tenant_id=YOUR_TENNANT_ID' \
    -var 'subscription_id=YOUR_SUBSCRIPTION_ID' \
    -var 'ssh_password=YOUR_SSH_PASSWORD' \
    -var 'managed_image_name=IMAGE_NAME' \
    -var 'app_binary_name=pricer-core-0.0.3-SNAPSHOT.jar' \
rhel.json
```

Ensure your application binary is in /packer/bin (copy it from target).

Then modify your Terraform script to use the image.

```
 storage_image_reference {
    id = "/subscriptions/YOUR_SUBSCRIPTION_ID/resourceGroups/HelloCloud/providers/Microsoft.Compute/images/IMAGE_NAME"
  }
```

## Workflow
This needs optimization.

* Perform setup as above
    * Create Service Principal
    * Create secret.tfvars
    * Create Packer script
* Create Packer image 
    * Build the project (mvn install)
    * Copy jar from target to /packer/bin
    * Run the script
* Deploy core resources (src/main/terraform-core)
    * Resource Group
    * VNET
    * Subnet
* Deploy Scale Set (src/main/terraform-scaleset)


## Jumpbox
Scale set VMs do not have externally routable ip addresses. In order SSH onto a scale set VM, a jumpbox (jump host) needs to be deployed 
into the VNET. This is a standalone with a public address. A separate Terraform script is provided for this. This also requires a 
custom Packer image that incorporates a complete SSH key pair.  


