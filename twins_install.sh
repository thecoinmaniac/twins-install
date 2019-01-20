#/bin/bash
cd ~
echo "****************************************************************************"
echo "*      This script will install and configure your TWINS masternodes.      *"
echo "*      If you have any issues please ask for help on the TWINS discord.    *"
echo "*                      https://discordapp.com/invite/zZbnYKV               *"
echo "*                        https://win.win/                                  *"
echo "****************************************************************************"
echo "" 
echo ""
echo ""
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!                                                 !"
echo "! Make sure you double check before hitting enter !"
echo "!                                                 !"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo ""
echo ""
echo ""
echo "Do you want to install all needed updates and firewall settings (no if you did it before)? [y/n]"
read DOSETUP
	if [[ $DOSETUP =~ "y" ]] || [[ $DOSETUP =~ "Y" ]] ; then
	sudo apt-get update
	sudo apt-get -y upgrade
	sudo apt-get -y dist-upgrade
	
	sudo apt-get install -y ufw
	sudo ufw allow ssh/tcp
	sudo ufw limit ssh/tcp
	sudo ufw logging on
	sudo ufw allow 22
	sudo ufw allow 37817
	echo "y" | sudo ufw enable
	sudo ufw status
fi

echo ""
wget https://win.win/wallets/twins-3.2.0.4-x86_64-linux-gnu.tar.gz
tar -xvzf twins-3.2.0.4-x86_64-linux-gnu.tar.gz
echo ""
echo "Configure your masternodes now!"
echo "Your recognised IP address is:"
sudo hostname -I | cut -d " " -f1
echo "Is this the IP you wish to use for MasterNode ? [y/n] , followed by [ENTER]"
read IPDEFAULT
	if [[ $IPDEFAULT =~ "y" ]] || [[ $IPDEFAULT =~ "Y" ]] ; then
	echo ""
	echo "We are using your default IP address"
	echo "Enter masternode private key for node, followed by [ENTER]: $ALIAS"
	read PRIVKEY
	CONF_DIR=~/.twins\/
	CONF_FILE=twins.conf
	PORT=37817
	IP=$(hostname -I | cut -d " " -f1)
	mkdir -p $CONF_DIR
	echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcpassword=passw"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
	echo "server=1" >> $CONF_DIR/$CONF_FILE
	echo "daemon=1" >> $CONF_DIR/$CONF_FILE
	echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
	echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
	echo "masternode=1" >> $CONF_DIR/$CONF_FILE
	echo "externalip=$IP" >> $CONF_DIR/$CONF_FILE
	echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
	cd twins-3.2.0/bin
	./twinsd -daemon
	echo "if server start failure try ./twins -reindex"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "!                                                 !"
	echo "! Your MasterNode Is setup please close terminal  !"
	echo "!   and continue the local wallet setup guide     !"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo ""
else	
	echo "Type the custom IP of this node, followed by [ENTER]:"
	read DIP
	echo ""
	echo "Enter masternode private key for node, followed by [ENTER]: $ALIAS"
	read PRIVKEY
	CONF_DIR=~/.twins\/
	CONF_FILE=twins.conf
	PORT=37817
	mkdir -p $CONF_DIR
	echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcpassword=passw"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
	echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
	echo "server=1" >> $CONF_DIR/$CONF_FILE
	echo "daemon=1" >> $CONF_DIR/$CONF_FILE
	echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
	echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
	echo "masternode=1" >> $CONF_DIR/$CONF_FILE
	echo "externalip=$DIP" >> $CONF_DIR/$CONF_FILE
	echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
	cd twins-3.2.0/bin
	./twinsd -daemon
	echo "if server start failure try ./twinsd -reindex"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "!                                                 !"
	echo "! Your MasterNode Is setup please close terminal  !"
	echo "!   and continue the local wallet setup guide     !"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo ""
fi

