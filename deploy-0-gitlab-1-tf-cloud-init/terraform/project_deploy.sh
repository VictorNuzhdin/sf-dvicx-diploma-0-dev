#!/bin/bash

CONFIG_DIR='configs'
SECRETS_DIR='protected'
CLOUD_INIT_CONFIG='protected/cloud-init_instance-data.json'
#CLOUD_INIT_CONFIG='/run/cloud-init/instance-data.json'
#
CLOUD_INIT_USER_NAME=$(cloud-init query --instance-data $CLOUD_INIT_CONFIG customdata.user_name)
CLOUD_INIT_USER_PASSWORD=$(cloud-init query --instance-data $CLOUD_INIT_CONFIG customdata.user_password)
CLOUD_INIT_USER_PUBKEY=$(cloud-init query --instance-data $CLOUD_INIT_CONFIG customdata.user_pubkey)
CUSTOM_SSH_PORT=822

##..copy template cloud-init config and inject sensitive data
rm -f $CONFIG_DIR/cloud-init.yaml
cp $CONFIG_DIR/cloud-init.yaml.tpl $CONFIG_DIR/cloud-init.yaml

##..replace template variables with values
sed -i -e "s/_CUSTOM_USER_NAME_/$CLOUD_INIT_USER_NAME/" $CONFIG_DIR/cloud-init.yaml
sed -i -e "s/_CUSTOM_USER_PASSWORD_/$CLOUD_INIT_USER_PASSWORD/" $CONFIG_DIR/cloud-init.yaml
sed -i -e "s/_CUSTOM_USER_PUBKEY_/$CLOUD_INIT_USER_PUBKEY/" $CONFIG_DIR/cloud-init.yaml
sed -i -e "s/_CUSTOM_SSH_PORT_/$CUSTOM_SSH_PORT/" $CONFIG_DIR/cloud-init.yaml

##..deploy terraform configuration/plan
clear; terraform validate; terraform plan; terraform apply -var-file="$SECRETS_DIR/protected.tfvars" --auto-approve

##..remove cloud-init config after terraform plan applied
#rm -f $CONFIG_DIR/cloud-init.yaml
