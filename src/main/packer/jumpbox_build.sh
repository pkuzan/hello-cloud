#!/usr/bin/env bash
packer build \
    -var 'tenant_id=14befade-1412-4362-bf99-0e0269eaaf72' \
    -var 'subscription_id=97cb539a-2f7f-42c7-b421-8343c7e9e73e' \
    -var 'client_id=8afcbef5-9fd2-4087-a8d4-a336513719cc' \
    -var 'client_secret=df2c986c-beef-40c4-94af-3edcb14c23d8' \
    -var 'ssh_password=password' \
    -var 'managed_image_name=jumpBoxImage2' \
jumpbox.json