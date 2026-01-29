##prac3  enumerating host, port, and service scanning
nmap --help(host, service snaming, enumeration)

sudo nmap -p1-65535- T4- A -v 192.168.187.0/24(port scan)
sudo nmap -sV ip of Metasploit(Service scan)
sudo nmap -sn -v ip of Metasploit(host scan)

sudo masscan Ip of Metasploit -p1-65535 --rate=100000

##############################33
on vitim
ifconfig

on Linux
ifconfig
nmap --version
nmap -sn 192.168.56.101
nmap -A 192.168.56.101
nmap -sV 192.168.56.101
nmap -O 192.168.56.101
#one command for all
nmap -A 192.168.56.101

