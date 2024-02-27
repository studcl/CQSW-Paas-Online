#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/cqsw-paas-config.sh 
apt -y install expect
##check Host Mapping
if grep -q "$Master_IP $Master_NAME" /etc/hosts; then
	echo "Host Mapping is Aleady"
else
	echo "$Master_IP $Master_NAME" >> /etc/hosts
fi
if grep -q "$Node_IP $Node_NAME" /etc/hosts; then
	echo "Host Mapping is Aleady"
else    
	echo "$Node_IP $Node_NAME" >> /etc/hosts
fi

if [[ ! -s ~/.ssh/id_rsa.pub ]]; then
	  ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa -q -b 2048
fi
name=$(hostname)
if [[ $name == $Master_NAME ]]; then
  expect -c "set timeout -1;
               spawn ssh-copy-id  -i /root/.ssh/id_rsa $Node_NAME;
               expect {
	       	   *password:* {send -- $Node_PASS\r;
		        expect {
			    *denied* {exit 2;}
			    eof}
		   }
		   *(yes/no* {send -- yes\r;exp_continue;}
		  eof         {exit 1;}
	  	}
		"
else
  expect -c "set timeout -1;
  	       spawn ssh-copy-id  -i /root/.ssh/id_rsa $Master_NAME;
	       expect {
	       	   *password:* {send -- $Master_PASS\r;
		   	expect {
			    *denied* {exit 2;}
			    eof}
		    }
		    *(yes/no* {send -- yes\r;exp_continue;}
		   eof         {exit 1;}
		}
		"
fi
##Check Timezone
timedatectl set-timezone Asia/Shanghai
if systemctl is-active ntp.service; then
	echo "ntp service is Already"
   else
	timedatectl set-ntp no
	apt install ntp -y
	systemctl enable ntp

fi
##Check Swap
sudo swapoff -a
sed -i '/swap/d' /etc/fstab
