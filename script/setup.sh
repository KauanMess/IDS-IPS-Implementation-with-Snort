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
      libssl-dev libnetfilter-queue-dev iptables \
      libpcap-dev libpcre3-dev libpcre2-dev libdaq-dev \
      bison flex libluajit-5.1-dev libdumbnet-dev \
      libc6 libc6-dev gcc g++ libtirpc-dev

ldconfig

export CFLAGS="-I/usr/include/tirpc"
export LDFLAGS="-ltirpc"

echo "### Downloading and installing Snort..."
SNORT_VERSION="2.9.20" # Change this to the latest version if necessary
wget https://www.snort.org/downloads/snort/snort-$SNORT_VERSION.tar.gz

tar -xvf snort-$SNORT_VERSION.tar.gz
cd snort-$SNORT_VERSION || exit

./configure --enable-optimizations --includedir=/usr/include/ntirpc/rpc
make -j$(nproc)
make install
ldconfig

# Check if Snort was installed successfully
if ! command -v snort &> /dev/null; then
    echo "Error: Snort was not installed successfully!"
    exit 1
fi

# Ensure /etc/snort is a directory
if [ -e /etc/snort ] && [ ! -d /etc/snort ]; then
    rm -f /etc/snort
fi
mkdir -p /etc/snort/rules
mkdir -p /var/log/snort
mkdir -p /usr/local/lib/snort_dynamicrules

# Copy modified configuration files from /docs to /etc/snort
cd ../../docs || exit
cp snort.conf /etc/snort/snort.conf
cp unicode.map /etc/snort/
cd - || exit

# Creating empty rule files
RULES=(
    "app-detect.rules" "attack-responses.rules" "backdoor.rules"
    "bad-traffic.rules" "blacklist.rules" "botnet-cnc.rules"
    "browser-chrome.rules" "browser-firefox.rules" "browser-ie.rules"
    "browser-other.rules" "browser-plugins.rules" "browser-webkit.rules"
    "chat.rules" "content-replace.rules" "ddos.rules" "dns.rules"
    "dos.rules" "experimental.rules" "exploit-kit.rules" "exploit.rules"
    "file-executable.rules" "file-flash.rules" "file-identify.rules"
    "file-image.rules" "file-multimedia.rules" "file-office.rules"
    "file-other.rules" "file-pdf.rules" "finger.rules" "ftp.rules"
    "icmp-info.rules" "icmp.rules" "imap.rules" "indicator-compromise.rules"
    "indicator-obfuscation.rules" "indicator-shellcode.rules" "info.rules"
    "malware-backdoor.rules" "malware-cnc.rules" "malware-other.rules"
    "malware-tools.rules" "misc.rules" "multimedia.rules" "mysql.rules"
    "netbios.rules" "nntp.rules" "oracle.rules" "os-linux.rules"
    "os-other.rules" "os-solaris.rules" "os-windows.rules"
    "other-ids.rules" "p2p.rules" "phishing-spam.rules"
    "policy-multimedia.rules" "policy-other.rules" "policy.rules"
    "policy-social.rules" "policy-spam.rules" "pop2.rules" "pop3.rules"
    "protocol-finger.rules" "protocol-ftp.rules" "protocol-icmp.rules"
    "protocol-imap.rules" "protocol-pop.rules" "protocol-services.rules"
    "protocol-voip.rules" "pua-adware.rules" "pua-other.rules"
    "pua-p2p.rules" "pua-toolbars.rules" "rpc.rules" "rservices.rules"
    "scada.rules" "scan.rules" "server-apache.rules" "server-iis.rules"
    "server-mail.rules" "server-mssql.rules" "server-mysql.rules"
    "server-oracle.rules" "server-other.rules" "server-webapp.rules"
    "shellcode.rules" "smtp.rules" "snmp.rules" "specific-threats.rules"
    "spyware-put.rules" "sql.rules" "telnet.rules" "tftp.rules"
    "virus.rules" "voip.rules" "web-activex.rules" "web-attacks.rules"
    "web-cgi.rules" "web-client.rules" "web-coldfusion.rules"
    "web-frontpage.rules" "web-iis.rules" "web-misc.rules"
    "web-php.rules" "x11.rules" "white_list.rules" "black_list.rules"
    "local.rules"
)

for rule in "${RULES[@]}"; do
    touch "/etc/snort/rules/$rule"
done

# Set permissions
chmod -R 5775 /etc/snort
chmod -R 5775 /var/log/snort

# Ensure the local.rules file exists before writing to it
touch /etc/snort/rules/local.rules
echo 'alert icmp any any -> any any (msg:"ICMP Packet Detected"; sid:10000001;)' > /etc/snort/rules/local.rules

# Test Snort
echo "### Testing Snort..."
snort -A console -c /etc/snort/snort.conf
