#!/usr/bin/bash

# token
token=$( cat .token )

# bucket
bucket='sciencedesk.economicsfromthetopdown.com'

# get new keys
cert=$( sudo cat /etc/letsencrypt/live/sciencedesk.economicsfromthetopdown.com/fullchain.pem )
key=$( sudo cat /etc/letsencrypt/live/sciencedesk.economicsfromthetopdown.com/privkey.pem )


# switch python environment
source /home/blair/.env/bin/activate

# delete old keys on linode
linode-cli object-storage ssl-delete \
  us-east-1 sciencedesk.economicsfromthetopdown.com 


# upload new keys to linode
linode-cli object-storage ssl-upload \
  us-east-1 sciencedesk.economicsfromthetopdown.com \
  --certificate "$cert" \
  --private_key "$key"

# check keys
linode-cli object-storage ssl-view \
  us-east-1 sciencedesk.economicsfromthetopdown.com 

