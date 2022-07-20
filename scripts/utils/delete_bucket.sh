#!/usr/bin/bash

bucket='blair.sciencedesk.info'

# delete files and directories
s3cmd del s3://"$bucket" --recursive --force

# delete bucket
linode-cli obj rb $bucket

