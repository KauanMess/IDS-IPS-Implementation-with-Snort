# IDS Implementation with Snort

## Project Overview

This project demonstrates how to set up and configure an Intrusion Detection System (IDS) or Intrusion Prevention System (IPS) using Snort in inline mode. The purpose is to alert and drop malicious traffic effectively, including ICMP, TCP, and HTTP packets.

The project provides a ready-to-use configuration for Snort, including:

- Rules to detect and drop specific types of traffic.
- Scripts to automate the setup process.
- A well-documented workflow for reproducing the environment.

## Table of Contents

1. [Dependencies](#dependencies)
2. [Setup Instructions](#setup-instructions)
3. [Assign IP](#assign-ip)
4. [Assign Interface](#assign-interface)
5. [Usage](#usage)
6. [Project Structure](#project-structure)
7. [Testing the Configuration](#testing-the-configuration)
8. [Contributing](#contributing)

---

## Dependencies

To run this project, ensure you have the following installed:

- **Ubuntu (or any Debian-based system)**
- **Snort 2.x**
- **libpcap-dev**
- **libpcre3-dev**
- **libdnet-dev**
- **bison**
- **flex**
- **iptables**

Remember to activate promiscuous mode and place all machines on an internal network/bridge in your virtual machine so that snort can act as an IDS/IPS, in this case we use VirtualBox but you just need to activate it too, as in the following image:

![Screenshot_11](https://github.com/user-attachments/assets/4d677551-db38-4cde-9de3-389098a982e4)

---

## Setup Instructions

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/KauanMess/IDS-IPS-Implementation-with-Snort.git
   cd IDS-IPS-Implementation-with-Snort
   ```

2. **Run the Setup Script**: Execute the `setup.sh` script to install Snort and configure it for inline mode:

   ```bash
   sudo ./scripts/setup.sh
   ```

3. When the installation is complete, snort will already be running in IDS mode, you can stop it with:
   ```bash
   ctrl+z
   ```
   ---
   
## Assign IP

- Check IP addresses
  ```bash
  ip a
  ```
- Add IP and mask to all machines on the network
  ```bash
  sudo ip addr add 192.168.x.x/24 dev <interface>
  ```
  
---
## Assign Interface

- If you are going to use it in IPS mode, remember that two network interfaces are required, otherwise only one is needed for IDS mode.
- Here we will be using two interfaces, one for input and one for output, you can check and change them as follows:
   ```bash
   ip a
   ip link set <interface> promisc on
   ip link set <interface> up
   ip a
   ```
- You will see something like:

![Screenshot_12](https://github.com/user-attachments/assets/afa33063-0a8f-4a8a-9a93-c00e04e72cb7)

## Usage

- **Start Snort in Inline Mode**:
  As snort inline mode requires 2 network interfaces, we will use it in IDS mode where anyone can use it, but if you want to use it as an IPS just use the syntax:
  ```bash
  sudo snort -Q --daq afpacket -i <interface>:<interface> -c /etc/snort/snort.conf -A console
  ```

  Replace `<interface>` with the network interface (e.g., `eth0:wlan0`).

  Here we use 3 machines (the Server, Kali Linux and Metaspoitable) you can see that pings are also blocked not only when done on the Server, but on any device on the network:

  ![Screenshot_8](https://github.com/user-attachments/assets/d609113b-1918-468f-b79a-141bda57613c)

  But as the focus is on it in IDS mode you can use the following syntax:
  ```bash
  snort -A console -c /etc/snort/snort.conf
  ```
  
- **Check Alerts**: By using the -A console syntax we can see it in real time, but you can consult the saved log alerts in `/var/log/snort/alert` by default. Use the following command to view them:

  ```bash
  tail -f /var/log/snort/alert
  ```

---

## Project Structure

The repository is organized as follows:

   ```
   IDS-IPS-Implementation-with-Snort/
   ├── README.md          # Project documentation
   ├── scripts/         # Automation scripts
   │   └── setup.sh   # Script to install Snort and dependencies
   ├── config/          # Configuration files
   │   ├── snort.conf # Main Snort configuration file
   │   └── local.rules # Custom rules for Snort
   ```

   ---

## Testing the Configuration

1. **Simulate ICMP Traffic**: From another machine, run:

   ```bash
   ping <Snort_IP>
   ```

   Snort should drop or alert on the ICMP packets.

2. **Simulate SSH Traffic**: Try to connect via SSH to the Snort machine:

   ```bash
   ssh user@<Snort_IP>
   ```

   Check if alerts are generated or packets are dropped.

3. **Simulate HTTP Traffic**: Use tools like `curl` or a web browser to make HTTP requests to a server behind Snort and observe the behavior.
   Here is a demonstration of a connection between machines where Snort is alerting and dropping packets between two machines:
---

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Describe your changes"
   ```
4. Push to your branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request.

---
For any questions or issues, feel free to open an issue in the repository!
