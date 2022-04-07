#cloud-config
# Ubuntu Server 20.04 LTS

autoinstall:
  version: 1

  early-commands:
  - sudo systemctl stop ssh
  - hostnamectl set-hostname ${hostname}
  - dhclient

  locale: en_US.UTF-8

  timezone: America/Chicago

  keyboard:
    layout: us

  identity:
    hostname: ubuntu-server
    username: ${ssh_username}
    password: ${ssh_password_encrypted}

  ssh:
    install-server: true
    allow-pw: true
    authorized-keys:
      - ${ssh_key}

  packages:
    - open-vm-tools

  user-data:
    disable_root: false

  network:
    version: 2
    ethernets:
      ens192:
        dhcp4: true
        dhcp6: true

  storage:
    layout:
      name: direct

  late-commands:
    - sed -i -e 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /target/etc/ssh/sshd_config
    - echo '${ssh_username} ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/${ssh_username}
    - curtin in-target --target=/target -- chmod 440 /etc/sudoers.d/${ssh_username}