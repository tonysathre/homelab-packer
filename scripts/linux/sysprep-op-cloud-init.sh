#!/usr/bin/env bash
#
# Remove all cloud-init run-time data and logs
#
# The removal completely resets cloud-init. When the instance is next
# started cloud-init will run all configured modules as if running for the
# first time
set -o errexit

rm -rf /var/lib/cloud/*
rm -f /var/log/cloud-init.log

# https://kb.vmware.com/s/article/80934
rm -rf /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg
rm -rf /etc/cloud/cloud.cfg.d/99-installer.cfg
#sudo apt purge cloud-init -y
#sudo apt autoremove -y
#sudo rm -rf /etc/cloud
#sudo sed -i 's/D /tmp/#D /tmp/g' /usr/lib/tmpfiles.d/tmp.conf
exit 0