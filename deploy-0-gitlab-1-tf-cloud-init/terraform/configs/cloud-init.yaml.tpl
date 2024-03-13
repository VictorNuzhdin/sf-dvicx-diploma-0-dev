#cloud-config
#
# 1. Adds custom user to the system with ssh-public-key and password
# 2. Configures ssh service custom port
# 3. Disables root access via ssh
#
#..creates custom user
users:
  - default
  - name: _CUSTOM_USER_NAME_
    gecos: Custom user
    primary_group: _CUSTOM_USER_NAME_
    groups: sudo
    sudo: 'ALL=(ALL) NOPASSWD:ALL'
    shell: /bin/bash
    lock_passwd: false
    passwd: _CUSTOM_USER_PASSWORD_
    ssh-authorized-keys:
      - _CUSTOM_USER_PUBKEY_

#..configures ssh: set custom ssh-port + disables root login via ssh
runcmd:
  - sed -i -e '$aPort _CUSTOM_SSH_PORT_' /etc/ssh/sshd_config
  - sed -i -e '$aPermitRootLogin No' /etc/ssh/sshd_config
  - sed -i -e '$aAllowUsers _CUSTOM_USER_NAME_' /etc/ssh/sshd_config
  - systemctl restart sshd
