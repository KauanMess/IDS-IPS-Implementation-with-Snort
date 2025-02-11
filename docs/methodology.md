## Methodology
To configure Snort, we perform the following steps:
1. Installing Snort on the Ubuntu desktop.
2. Configuration of the `snort.conf` file for monitoring ICMP packets.
3. Configuring the `local.rules` file to alert/drop ICMP packets or TCP/HTTP connections, etc. (For example, for an alert on an SSH connection attempt you can add this line to local.rules: alert any any -> any 22 (msg:"SSH connection attempt detected; sid:1000001; rev:1; "))
4. Configuring network segmentation on machines on an internal network (for example 192.168.1.1/24 & 192.168.1.2/24) so ​​that Snort can monitor the internal network
5. Running tests with the `ping` command while Snort is running to test its operation.

## Results
After running the `ping` tests and checking the Snort logs, it was possible to detect malicious packets being blocked.
