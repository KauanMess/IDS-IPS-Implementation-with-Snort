# IDS-IPS-Implementation-with-Snort
A simple project implementing IDS and IPS systems with the Snort tool.
# IDS Implementation with Snort

## Overview
This project demonstrates the implementation of an intrusion detection system (IDS) using Snort, focusing on detecting and blocking malicious packets on an internal network.

## Technologies Used
- **Snort**: IDS/IPS tool for packet monitoring.
- **Kali Linux**: Operating system for penetration testing and traffic generation.
- **Metasploitable**: Vulnerable machine used to simulate attacks.
- **Ubuntu 20.04.6 desktop**

## Objective
The objective of this project is to demonstrate how Snort can be configured to block ICMP packets (ping) and other threats by monitoring traffic on an internal network.

## Steps for Execution
1. Clone this repository:
   ```bash
   git clone https://github.com/seu-usuario/IDS-Implementation-with-Snort.git
2. Install Snort.
   ```bash
   apt-get install snort
4. Run the scripts to configure and test Snort.

5. You can edit and add rules in /etc/snort/rules/local.rules for example:(drop tcp any 80 -> any any (msg:"Blocking HTTP Connection"; sid:1000004;)

6. 
