##Results
The results should look like these:

02/05-11:36:01.558905 [**] [1:1000001:0] ICMP Ping Detected [**] [Priority: 0] {ICMP) 192.168.1.101 -> 192.168.1.100
02/10-20:47:24.915957 [Drop] [**] [1:1000003:0] Blocking ICMP Packet [**] [Priority: 0] {ICMP} 192.168.1.3 -> 192.168.1.2
02/10-20:47:24.916144 [Drop] [**] [1:1000003:0] Blocking ICMP Packet [**] [Priority: 0] {ICMP} 192.168.1.2 -> 192.168.1.3
02/10-20:47:25.013523 [Drop] [**] [1:1000003:0] Blocking ICMP Packet [**] [Priority: 0] {ICMP} 192.168.1.2 -> 192.168.1.3
02/11-10:17:31.076786 [Drop] [**] [1:1000004:0] Blocking HTTP Connection [**] [ Priority: 0] {TCP} 192.168.1.3:80 -> 192.168.1.2:57194
02/11-10:17:31.080664 [Drop] [**] [1:1000004:0] Blocking HTTP Connection [**] [ Priority: 0] {TCP} 192.168.1.3:80 -> 192.168.1.2:57206
02/11-10:17:31.083503 [Drop] [**] [1:1000004:0] Blocking HTTP Connection [**] [ Priority: 0] {TCP} 192.168.1.3:80 -> 192.168.1.2:57222
02/11-10:15:04.074869 [Drop] [**] [1:1000004:0] Blocking SSH Connection [**] [P riority: 0] {TCP} 192.168.1.2:48374 -> 192.168.1.3:22
02/11-10:15:04.308539 [Drop] [**] [1:1000004:0] Blocking SSH Connection [**] [P riority: 0] {TCP} 192.168.1.2:48390 -> 192.168.1.3:22
02/11-10:15:04.549294 [Drop] [**] [1:1000004:0] Blocking SSH Connection [**] [P riority: 0] {TCP} 192.168.1.2:48396 -> 192.168.1.3:22

Remembering that the "Blocking ICMP packet" warning and other warnings can be edited according to your preference in 
/etc/snort/rules/local.rules

