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
     bison flex libluajit-5.1-dev libdumbnet-dev libssl-dev \
     libc6 libc6dev gcc g++
apt install --reinstall build-essential gcc g++ -y
apt install --reinstall libc6 libc6-dev -y

sudo ldconfig

export CFLAGS="-I/usr/include/tirpc"
export LDFLAGS="-ltirpc"

echo "### Downloading and installing Snort..."
SNORT_VERSION="2.9.20" # Change this to the latest version if necessary
wget https://www.snort.org/downloads/snort/snort-$SNORT_VERSION.tar.gz
tar -xvf snort-$SNORT_VERSION.tar.gz
cd snort-$SNORT_VERSION

./configure --enable-optimizations --includedir=/usr/include/ntirpc/rpc
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

echo "### Creating a simple rule..."
echo 'alert icmp any any -> any any (msg:"ICMP Packet Detected"; sid:10000001;)' > /etc/snort/rules/local.rules

echo "### Setting up iptables to redirect packets to Snort..."
iptables -A INPUT -j NFQUEUE --queue-num 1
iptables -A OUTPUT -j NFQUEUE --queue-num 1

echo "### Testing Snort..."
snort -A console -c /etc/snort/snort.conf
