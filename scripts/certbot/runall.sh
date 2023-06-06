#!/usr/bin/bash

# run script as normal user

# copy to path
cp 01_authenticate.sh 02_cleanup.sh /home/blair/.local/bin


# get certificate
sudo certbot certonly \
    --manual \
    --preferred-challenges=http \
    --manual-auth-hook 01_authenticate.sh \
    --manual-cleanup-hook 02_cleanup.sh \
    -d sciencedesk.economicsfromthetopdown.com


# upload to linode
./03_upload_key.sh
