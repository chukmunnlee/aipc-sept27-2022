#!/bin/bash
docker-machine create \
    --driver generic \
    --generic-ip-address 128.199.73.182 \
    --generic-ssh-user root \
    --generic-ssh-key /opt/tmp/abc \
    my-docker-machine