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
&lt;servers&gt;
   &lt;server&gt;
     &lt;id&gt;azure-auth&lt;/id&gt;
      &lt;configuration&gt;
         &lt;client&gt;CLIENT-ID&lt;/client&gt;
         &lt;tenant&gt;TENNANT-ID&lt;/tenant&gt;
         &lt;key&gt;PASSWORD&lt;/key&gt;
         &lt;environment&gt;AZURE&lt;/environment&gt;
      &lt;/configuration&gt;
   &lt;/server&gt;
&lt;/servers&gt;
```

You can then run the dockerfile:build to build an image and dockerfile:push to push the image to ACR.
Then run azure-webapp:deploy to deploy to App Service.
