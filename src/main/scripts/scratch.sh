#!/bin/bash
# Just a command scratch pad.

https://linuxacademy.com/howtoguides/posts/show/topic/20146-a-complete-azure-environment-with-terraform

[
  {
    "cloudName": "AzureCloud",
    "id": "a7e7a5e8-958c-46b5-aced-3ce0d5b6f502",
    "isDefault": true,
    "name": "Free Trial",
    "state": "Enabled",
    "tenantId": "f5af8153-415e-41d1-be4d-b2113b1bf62d",
    "user": {
      "name": "paul_kuzan@hotmail.com",
      "type": "user"
    }
  }
]

https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure

az account show --query "{subscriptionId:id, tenantId:tenantId}"
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/a7e7a5e8-958c-46b5-aced-3ce0d5b6f502"
{
  "appId": "913f2824-61dc-4608-b3c3-d878342c8199",
  "displayName": "azure-cli-2018-04-04-08-18-49",
  "name": "http://azure-cli-2018-04-04-08-18-49",
  "password": "12a3469c-2f5e-44c1-8d9c-27a317b9e45d",
  "tenant": "f5af8153-415e-41d1-be4d-b2113b1bf62d"
}
az login --service-principal -u http://azure-cli-2018-04-04-08-18-49 -p 12a3469c-2f5e-44c1-8d9c-27a317b9e45d --tenant f5af8153-415e-41d1-be4d-b2113b1bf62d
az vm list-sizes --location westus

ssh -i ~/.ssh/azure azureuser@52.191.11.126

Install CLI
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
sudo yum -y install azure-cli
sudo yum -y install java-1.8.0-openjdk
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --reload

BLOB STORAGE

az storage account keys list \
    --account-name azurehellocloud007 \
    --resource-group HelloCloud \
    --output table

az storage blob delete \
--container-name hello-cloud-storage-container \
--name hello-cloud-bin \
--account-name diag7258dddfcf14cd58 \
--account-key VY4rdQxjyoLXPVOWIEGO3skR9LjYouP30As4/ggz9HNd+3q/hziSNtasUd2EUq04tVZ+mSvhkYhuI2LT2GjdlA==


az storage blob upload \
    --container-name hello-cloud-storage-container \
    --name hello-cloud-bin \
    --account-name azurehellocloud007 \
    --account-key 4O9EgbWqkj01GiTgpWQNsAGmUPLHAQuDDbNQ6cf+7kmK+Z3fNwnLDYiSWqb+TLz9jIEGk4Yug+U9FOhvWyRL4g== \
    --file /Users/pkuzan/dev/azure/hello-cloud/target/pricer-core-0.0.3-SNAPSHOT.jar

az storage blob upload \
    --container-name hello-cloud-storage-container \
    --name start_server.sh \
    --account-name azurehellocloud007 \
    --account-key AX84imGQ0hYbbZER0z6PuzKqpAj06P/PYiGkwpxbnLmrjDBA47MSp/9V7Ni+y0a8wI8rKH7nuS9wdLWOYEDQAA== \
    --file /Users/pkuzan/dev/azure/hello-cloud/src/main/scripts/start_server.sh


az storage blob list \
    --container-name hello-cloud-storage-container \
	--account-name diag7258dddfcf14cd58 \
	--account-key VY4rdQxjyoLXPVOWIEGO3skR9LjYouP30As4/ggz9HNd+3q/hziSNtasUd2EUq04tVZ+mSvhkYhuI2LT2GjdlA== \
 	--output table

az storage blob download \
                                           --container-name hello-cloud-storage-container \
                                           --name hello-cloud-bin \
                                           --account-name azurehellocloud007 \
                                           --account-key 4O9EgbWqkj01GiTgpWQNsAGmUPLHAQuDDbNQ6cf+7kmK+Z3fNwnLDYiSWqb+TLz9jIEGk4Yug+U9FOhvWyRL4g== \
                                           --file ~/hellocloud/pricer-core.jar

az storage blob download \
    --container-name hello-cloud-storage-container \
    --name start_server.sh \
    --account-name azurehellocloud007 \
    --account-key AX84imGQ0hYbbZER0z6PuzKqpAj06P/PYiGkwpxbnLmrjDBA47MSp/9V7Ni+y0a8wI8rKH7nuS9wdLWOYEDQAA== \
    --file ~/hellocloud/start_server.sh

az ad sp create-for-rbac --name "hello-cloud" --password "myPassword14+"
{
  "appId": "74af903f-7c3a-4186-917e-c7c1ebac3f9f",
  "displayName": "hello-cloud",
  "name": "http://hello-cloud",
  "password": "myPassword14+",
  "tenant": "f5af8153-415e-41d1-be4d-b2113b1bf62d"
}
<servers>
   <server>
     <id>azure-auth</id>
      <configuration>
         <client>74af903f-7c3a-4186-917e-c7c1ebac3f9f</client>
         <tenant>f5af8153-415e-41d1-be4d-b2113b1bf62d</tenant>
         <key>myPassword14+</key>
         <environment>AZURE</environment>
      </configuration>
   </server>
</servers>

az acr create --admin-enabled --resource-group HelloCloud --location westus --name hellocloudregistry --sku Basic

  "adminUserEnabled": true,
  "creationDate": "2018-04-23T10:38:23.382608+00:00",
  "id": "/subscriptions/a7e7a5e8-958c-46b5-aced-3ce0d5b6f502/resourceGroups/HelloCloud/providers/Microsoft.ContainerRegistry/registries/hellocloudregistry",
  "location": "westus",
  "loginServer": "hellocloudregistry.azurecr.io",
  "name": "hellocloudregistry",
  "provisioningState": "Succeeded",
  "resourceGroup": "HelloCloud",
  "sku": {
    "name": "Basic",
    "tier": "Basic"
  },
  "status": null,
  "storageAccount": null,
  "tags": {},
  "type": "Microsoft.ContainerRegistry/registries"
}
az acr credential show --name hellocloudregistry --query passwords[0]
{
  "name": "password",
  "value": "nSy+3JYTW0Zyg32TKZa/KUfJnIrDmsG/"
}
<servers>
   <server>
      <id>hellocloudregistry</id>
      <username>hellocloudregistry</username>
      <password>nSy+3JYTW0Zyg32TKZa/KUfJnIrDmsG/</password>
   </server>
</servers>