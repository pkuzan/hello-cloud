#!/bin/bash
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
sudo yum install azure-cli
sudo yum install java-1.8.0-openjdk

# How do you do this without knowing the key?
# Need a static storage account name
#az storage blob download \
    --container-name hello-cloud-storage-container \
    --name hello-cloud-bin \
    --account-name diag27b1bba0d617eee6 \
    --account-key FZmYrh7yrKMRJ7V+eg6RS9FyIXfYLOb3hlFgmVGBQG1PACdv064/dulCoHucGrOE6aj0Cxfc2qonlY1bNN8JFQ== \
    --file ~/hellocloud/pricer-core.jar