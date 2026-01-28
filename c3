##prac3  enumerating host, port, and service scanning
nmap --help(host, service snaming, enumeration)

sudo nmap -p1-65535- T4- A -v 192.168.187.0/24(port scan)
sudo nmap -sV ip of Metasploit(Service scan)
sudo nmap -sn -v ip of Metasploit(host scan)

sudo masscan Ip of Metasploit -p1-65535 --rate=100000

