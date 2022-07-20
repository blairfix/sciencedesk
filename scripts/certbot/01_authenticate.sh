#!/usr/bin/bash

# get cert key
echo $CERTBOT_VALIDATION > /home/blair/Dropbox/cloud_work/science_desk/static/.well-known/acme-challenge/$CERTBOT_TOKEN

# sync key to server
cd /home/blair/Dropbox/cloud_work/science_desk/

# run hugo
hugo

# send cert to linode
s3cmd \
    --config="/home/blair/.s3cfg" \
    --no-mime-magic \
    --acl-public \
    --delete-removed \
    --delete-after \
    sync public/ \
    s3://sciencedesk.economicsfromthetopdown.com


# wait a bit
sleep 20


