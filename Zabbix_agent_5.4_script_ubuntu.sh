#!/bin/bash
sudo -i
apt update -y && apt upgrade -y
wget https://repo.zabbix.com/zabbix/5.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.4-1+ubuntu20.04_all.deb
dpkg -i zabbix-release_5.4-1+ubuntu20.04_all.deb
apt update -y
apt install zabbix-agent -y
name=$(hostname -f)
echo Hostname=$name > /etc/zabbix/zabbix_agentd.conf
echo 'PidFile=/run/zabbix/zabbix_agentd.pid' >> /etc/zabbix/zabbix_agentd.conf
echo 'LogFile=/var/log/zabbix/zabbix_agentd.log' >> /etc/zabbix/zabbix_agentd.conf
echo 'LogFileSize=0' >> /etc/zabbix/zabbix_agentd.conf
echo 'Server=3.7.21.133' >> /etc/zabbix/zabbix_agentd.conf
echo 'ListenPort=10050' >> /etc/zabbix/zabbix_agentd.conf
echo 'ServerActive=3.7.21.133' >> /etc/zabbix/zabbix_agentd.conf
echo 'Include=/etc/zabbix/zabbix_agentd.d/*.conf' >> /etc/zabbix/zabbix_agentd.conf
systemctl restart zabbix-agent
systemctl enable zabbix-agent
apt install firewalld -y
firewall-cmd --add-port=10050/tcp
