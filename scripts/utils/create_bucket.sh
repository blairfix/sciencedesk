#!/usr/bin/bash

# run hugo
hugo --cleanDestinationDir

# bucket name
#bucket='blair.sciencedesk.info'
bucket='sciencedesk.economicsfromthetopdown.com'

# make bucket
linode-cli obj mb $bucket

s3cmd ws-create --ws-index=index.html --ws-error=404.html s3://"$bucket"

# linode cli
linode-cli obj ws-create "$bucket" --ws-index=index.html --ws-error=404.html
linode-cli obj setacl --acl-public "$bucket" index.html
linode-cli obj setacl --acl-public "$bucket" 404.html


# sync
s3cmd --no-mime-magic --acl-public --delete-removed --delete-after sync public/ s3://"$bucket"

