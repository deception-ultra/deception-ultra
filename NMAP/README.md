##############################################
##                DISCLAIMER                ##
##############################################

It is important to ensure that you have the legal authority to run these tools and scripts on a target network.


Nmap cmds

nmap -p 139,445 --script smb-os-discovery 192.168.1.0/24

nmap -p 445 --script smb-vuln-ms17-010 192.168.1.0/24

nmap -p 80,443 --script http-enum 192.168.1.0/24

nmap -p 21 --script ftp-anon 192.168.1.0/24

nmap -p 53 --script dns-zone-transfer 192.168.1.0/24

nmap -p 25 --script smtp-vuln-cve2010-4344 192.168.1.0/24

nmap -p 443 --script ssl-heartbleed 192.168.1.0/24

nmap -p 80,443 --script http-sql-injection 192.168.1.0/24

nmap -p 139,445 --script smb-vuln-ms08-067 192.168.1.0/24

nmap -p 22 --script ssh-brute --script-args userdb=usernames.txt,passdb=passwords.txt 192.168.1.0/24
