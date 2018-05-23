#!/usr/bin/env bash
packer build -var `client_id=8afcbef5-9fd2-4087-a8d4-a336513719cc` -var `client_secret=df2c986c-beef-40c4-94af-3edcb14c23d8` rhel.json
