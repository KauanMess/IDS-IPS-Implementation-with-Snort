# IDS/IPS Implementation with Snort

This project demonstrates how to set up and configure an Intrusion Detection System (IDS) and Intrusion Prevention System (IPS) using Snort in inline mode. The purpose is to alert and drop malicious traffic effectively, including ICMP, TCP, and HTTP packets.

## Project Overview

The project provides a ready-to-use configuration for Snort, including:

- Rules to detect and drop specific types of traffic.
- Scripts to automate the setup process.
- A well-documented workflow for reproducing the environment.

## Table of Contents

1. [Dependencies](#dependencies)
2. [Setup Instructions](#setup-instructions)
3. [Usage](#usage)
4. [Project Structure](#project-structure)
5. [Testing the Configuration](#testing-the-configuration)
6. [Contributing](#contributing)
7. [License](#license)

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

Install dependencies using the following command:

```bash
sudo apt update && sudo apt install -y build-essential libpcap-dev libpcre3-dev libdnet-dev bison flex iptables
```

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

3. **Verify Configuration**: Check if Snort is correctly installed and running:

   ```bash
   snort -V
   ```

---

## Usage

- **Start Snort in Inline Mode**:

  ```bash
  sudo snort -Q -c /etc/snort/snort.conf -i <interface>
  ```

  Replace `<interface>` with the network interface (e.g., `eth0`).

- **Check Alerts**: Alerts are stored in `/var/log/snort/alert` by default. Use the following command to view them:

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
