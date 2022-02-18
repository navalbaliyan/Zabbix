#!/bin/bash
sudo -i
yum update -y
rpm -Uvh https://repo.zabbix.com/zabbix/5.4/rhel/8/x86_64/zabbix-release-5.4-1.el8.noarch.rpm
yum update -y
yum install zabbix-agent -y
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
yum install firewalld -y
firewall-cmd --permanent --add-port=10050/tcp
firewall-cmd --reload
