#!/bin/bash

CONFIG_DIR='configs'
SECRETS_DIR='protected'

##..destroy cloud resources
clear; terraform destroy -var-file="$SECRETS_DIR/protected.tfvars" --auto-approve

##..remove cloud-init config
rm -f $CONFIG_DIR/cloud-init.yaml
