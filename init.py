#!/usr/bin/python3
import os
import fileinput
import subprocess

acl_id = os.environ.get('ACL_ID')

if acl_id is not None:
    with fileinput.FileInput('/etc/fail2ban/action.d/aws-acl-action.conf', inplace=True, backup='.bak') as file:
        for line in file:
            print(line.replace('<acl-id>', acl_id), end='')
else:
    print('ERROR: Please run docker container with environment variable')
