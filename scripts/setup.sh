#!/bin/bash

# Ensure the script is run as root or with sudo
if [ "$(whoami)" != "root" ]; then
    echo "Please run this script as root or using sudo!"
    exit 1
fi

echo "### Updating the system..."
apt-get update && apt-get upgrade -y

echo "### Installing Snort dependencies..."
apt-get install -y build-essential zlib1g-dev \
      libssl-dev libnetfilter-queue-dev iptables

apt install -y libpcap-dev libpcre3-dev libpcre2-dev libdaq-dev \
     bison flex libluajit-5.1-dev libdumbnet-dev libssl-dev

echo "### Downloading and installing Snort..."
SNORT_VERSION="2.9.20" # Change this to the latest version if necessary
wget https://www.snort.org/downloads/snort/snort-$SNORT_VERSION.tar.gz
tar -xvf snort-$SNORT_VERSION.tar.gz
cd snort-$SNORT_VERSION

./configure --enable-sourcefire
make
make install
ldconfig

# Check if Snort was installed successfully
if ! command -v snort &> /dev/null; then
    echo "Error: Snort was not installed successfully!"
    exit 1
fi

echo "### Configuring Snort directories and libraries..."
mkdir -p /etc/snort/rules
mkdir -p /var/log/snort
mkdir -p /usr/local/lib/snort_dynamicrules

touch /etc/snort/rules/local.rules
cp etc/*.conf* /etc/snort/

echo "### Setting permissions..."
chmod -R 5775 /etc/snort
chmod -R 5775 /var/log/snort

echo "### Configuring the snort.conf file..."
SNORT_CONF="/etc/snort/snort.conf"

# Comment out other rule paths and add the custom local.rules
sed -i 's/include \$RULE_PATH/# include \$RULE_PATH/' $SNORT_CONF
echo "include \$RULE_PATH/local.rules" >> $SNORT_CONF
echo "config policy_mode:inline" >> $SNORT_CONF

echo "### Creating a simple rule to test inline mode..."
echo 'alert icmp any any -> any any (msg:"ICMP Packet Detected"; sid:10000001; rev:001;)' > /etc/snort/rules/local.rules

echo "### Setting up iptables to redirect packets to Snort..."
iptables -A INPUT -j NFQUEUE --queue-num 1
iptables -A OUTPUT -j NFQUEUE --queue-num 1

echo "### Testing Snort in inline mode..."
snort -Q --daq nfq --daq-var queue=1 -c $SNORT_CONF
