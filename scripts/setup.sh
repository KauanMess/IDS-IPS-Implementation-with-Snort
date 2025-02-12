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
     libc6 libc6-dev gcc g++
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
touch /etc/snort/rules/app-detect.rules
touch /etc/snort/rules/attack-responses.rules
touch /etc/snort/rules/backdoor.rules
touch /etc/snort/rules/bad-traffic.rules
touch /etc/snort/rules/blacklist.rules
touch /etc/snort/rules/botnet-cnc.rules
touch /etc/snort/rules/browser-chrome.rules
touch /etc/snort/rules/browser-firefox.rules
touch /etc/snort/rules/browser-ie.rules
touch /etc/snort/rules/browser-other.rules
touch /etc/snort/rules/browser-plugins.rules
touch /etc/snort/rules/browser-webkit.rules
touch /etc/snort/rules/chat.rules
touch /etc/snort/rules/content-replace.rules
touch /etc/snort/rules/ddos.rules
touch /etc/snort/rules/dns.rules
touch /etc/snort/rules/dos.rules
touch /etc/snort/rules/experimental.rules
touch /etc/snort/rules/exploit-kit.rules
touch /etc/snort/rules/exploit.rules
touch /etc/snort/rules/file-executable.rules
touch /etc/snort/rules/file-flash.rules
touch /etc/snort/rules/file-identify.rules
touch /etc/snort/rules/file-image.rules
touch /etc/snort/rules/file-multimedia.rules
touch /etc/snort/rules/file-office.rules
touch /etc/snort/rules/file-other.rules
touch /etc/snort/rules/file-pdf.rules
touch /etc/snort/rules/finger.rules
touch /etc/snort/rules/ftp.rules
touch /etc/snort/rules/icmp-info.rules
touch /etc/snort/rules/icmp.rules
touch /etc/snort/rules/imap.rules
touch /etc/snort/rules/indicator-compromise.rules
touch /etc/snort/rules/indicator-obfuscation.rules
touch /etc/snort/rules/indicator-shellcode.rules
touch /etc/snort/rules/info.rules
touch /etc/snort/rules/malware-backdoor.rules
touch /etc/snort/rules/malware-cnc.rules
touch /etc/snort/rules/malware-other.rules
touch /etc/snort/rules/malware-tools.rules
touch /etc/snort/rules/misc.rules
touch /etc/snort/rules/multimedia.rules
touch /etc/snort/rules/mysql.rules
touch /etc/snort/rules/netbios.rules
touch /etc/snort/rules/nntp.rules
touch /etc/snort/rules/oracle.rules
touch /etc/snort/rules/os-linux.rules
touch /etc/snort/rules/os-other.rules
touch /etc/snort/rules/os-solaris.rules
touch /etc/snort/rules/os-windows.rules
touch /etc/snort/rules/other-ids.rules
touch /etc/snort/rules/p2p.rules
touch /etc/snort/rules/phishing-spam.rules
touch /etc/snort/rules/policy-multimedia.rules
touch /etc/snort/rules/policy-other.rules
touch /etc/snort/rules/policy.rules
touch /etc/snort/rules/policy-social.rules
touch /etc/snort/rules/policy-spam.rules
touch /etc/snort/rules/pop2.rules
touch /etc/snort/rules/pop3.rules
touch /etc/snort/rules/protocol-finger.rules
touch /etc/snort/rules/protocol-ftp.rules
touch /etc/snort/rules/protocol-icmp.rules
touch /etc/snort/rules/protocol-imap.rules
touch /etc/snort/rules/protocol-pop.rules
touch /etc/snort/rules/protocol-services.rules
touch /etc/snort/rules/protocol-voip.rules
touch /etc/snort/rules/pua-adware.rules
touch /etc/snort/rules/pua-other.rules
touch /etc/snort/rules/pua-p2p.rules
touch /etc/snort/rules/pua-toolbars.rules
touch /etc/snort/rules/rpc.rules
touch /etc/snort/rules/rservices.rules
touch /etc/snort/rules/scada.rules
touch /etc/snort/rules/scan.rules
touch /etc/snort/rules/server-apache.rules
touch /etc/snort/rules/server-iis.rules
touch /etc/snort/rules/server-mail.rules
touch /etc/snort/rules/server-mssql.rules
touch /etc/snort/rules/server-mysql.rules
touch /etc/snort/rules/server-oracle.rules
touch /etc/snort/rules/server-other.rules
touch /etc/snort/rules/server-webapp.rules
touch /etc/snort/rules/shellcode.rules
touch /etc/snort/rules/smtp.rules
touch /etc/snort/rules/snmp.rules
touch /etc/snort/rules/specific-threats.rules
touch /etc/snort/rules/spyware-put.rules
touch /etc/snort/rules/sql.rules
touch /etc/snort/rules/telnet.rules
touch /etc/snort/rules/tftp.rules
touch /etc/snort/rules/virus.rules
touch /etc/snort/rules/voip.rules
touch /etc/snort/rules/web-activex.rules
touch /etc/snort/rules/web-attacks.rules
touch /etc/snort/rules/web-cgi.rules
touch /etc/snort/rules/web-client.rules
touch /etc/snort/rules/web-coldfusion.rules
touch /etc/snort/rules/web-frontpage.rules
touch /etc/snort/rules/web-iis.rules
touch /etc/snort/rules/web-misc.rules
touch /etc/snort/rules/web-php.rules
touch /etc/snort/rules/x11.rules
touch /etc/snort/rules/white_list.rules
touch /etc/snort/rules/black_list.rules
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
