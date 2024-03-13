#!/bin/bash

##..tests
# ssh -p 822 devops@158.160.86.105
# ssh -o StrictHostKeyChecking=no -p822 devops@158.160.86.105
#
# echo $(jq '.outputs' terraform.tfstate)                               ## { "host0_info": { "value": "gitlab: gitlab: 10.0.10.11: 158.160.0.174", "type": "string" }, "host0_ip_external": { "value": "158.160.0.174", "type": "string" } }
# echo $(jq '.outputs.host0_ip_external.value' terraform.tfstate)       ## "158.160.0.174"
# echo $(jq -r '.outputs.host0_ip_external.value' terraform.tfstate)    ## 158.160.0.174
#

##..finally
ssh -o StrictHostKeyChecking=no -p822 devops@$(jq -r '.outputs.host0_ip_external.value' terraform.tfstate)
