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

ssh -i ~/.ssh/azure azureuser@52.234.230.55

Install CLI
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc \
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo' \
sudo yum -y install azure-cli \
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
    --account-key IbSAvXfcUYZT0B08jvOtS3GxKTUoGqGPBS13LpwXUA5QiligGxumrBgsOc1xiCL3qz3tylL7cPL9MxAVi/yiNg== \
    --file /Users/pkuzan/dev/azure/hello-cloud/target/pricer-core-0.0.3-SNAPSHOT.jar

az storage blob list \
    --container-name hello-cloud-storage-container \
	--account-name diag7258dddfcf14cd58 \
	--account-key VY4rdQxjyoLXPVOWIEGO3skR9LjYouP30As4/ggz9HNd+3q/hziSNtasUd2EUq04tVZ+mSvhkYhuI2LT2GjdlA== \
 	--output table

az storage blob download \
    --container-name hello-cloud-storage-container \
    --name hello-cloud-bin \
    --account-name azurehellocloud007 \
    --account-key IbSAvXfcUYZT0B08jvOtS3GxKTUoGqGPBS13LpwXUA5QiligGxumrBgsOc1xiCL3qz3tylL7cPL9MxAVi/yiNg== \
    --file ~/hellocloud/pricer-core.jar

az vm open-port --port 8080 --resource-group HelloCloud --name helloCloudVM
