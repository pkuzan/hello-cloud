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

## Docker
You'll need to create a service principal.

```
az login
az ad sp create-for-rbac --name "NAME" --password "PASSWORD"
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

In your Maven settings.xml add the following, replacing the placeholders with your values.:

```
<servers>
   <server>
     <id>azure-auth</id>
      <configuration>
         <client>CLIENT-ID</client>
         <tenant>TENNANT-ID</tenant>
         <key>PASSWORD</key>
         <environment>AZURE</environment>
      </configuration>
   </server>
</servers>
```

You can then run the dockerfile:build to build an image and dockerfile:push to push the image to ACR.
Then run azure-webapp:deploy to deploy to App Service.

## Packer
A Packer build file is also included.
To use, the Packer executable needs to be installed from https://www.packer.io/

Variables will need to be passed to Packer to run the script. Best thing to do is to create a script.
SSH password can be anything.

```
#!/usr/bin/env bash
packer build \
    -var 'client_id=YOUR_CLIENT_ID' \
    -var 'client_secret=YOUR_CLENT_SECRET' \
    -var 'tenant_id=YOUR_TENNANT_ID' \
    -var 'subscription_id=YOUR_SUBSCRIPTION_ID' \
    -var 'ssh_password=YOUR_SSH_PASSWORD' \
    -var 'managed_image_name=helloCloudImage6' \
    -var 'app_binary_name=pricer-core-0.0.3-SNAPSHOT.jar' \
rhel.json
```

Ensure your application binary is in /packer/bin (copy is from target).

Then mofify your Terraform script to use the image.

```
 storage_image_reference {
    id = "/subscriptions/YOUR_SUBSCRIPTION_ID/resourceGroups/HelloCloud/providers/Microsoft.Compute/images/helloCloudImage6"
  }
```

