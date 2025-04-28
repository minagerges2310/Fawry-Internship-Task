# Task1: mygrip.sh
This a min version of the `grep` command that have the basic funcnality.
It can search for words inside a text file and supports options to show line numbers and invert matches.

##Features
Case-insensitive search (default).

Options supported:

`-n`:Show line numbers.

`-v`: Invert match (show lines that do not match).

`--help`: To show how to use the command.

Combined options like `-vn` or `-nv` are supported.

Error handling for missing arguments.

## Exampels:
`./mygrep.sh hello testfile.txt`


![image](https://github.com/user-attachments/assets/76e3c03b-3572-4525-96fe-e3441d379b92)

`./mygrep.sh -n hello testfile.txt`


![image](https://github.com/user-attachments/assets/ad2ec86b-81d0-4ef5-abf8-6888f71ec692)

`./mygrep.sh -vn hello testfile.txt`


![image](https://github.com/user-attachments/assets/5293f493-45ec-482a-98cf-d79779535744)

`./mygrep.sh -v testfile.txt`


![image](https://github.com/user-attachments/assets/82c7f14b-9d3f-447c-86b3-ce830bde5b7b)

`./mygrep.sh --help`


![image](https://github.com/user-attachments/assets/40315075-20ec-4276-bd54-2608499809ed)

##Reflective Section

### 1. The script handles the arguments using `getopts` the script handle the options `-n` `-v` each option in a case statement and the invalid options triggers an error message 

After that `shift $((OPTIND - 1))` moves the remaining arguments into position 

The script uses 2 positional arguments S1,S2 the script then checks of the 2 arguments are present if not it gives an error 

Also the script checks if the file exists using `[[ -f "$file" ]]` if not it prints an error message 

### 2-If the script would support regex or more options like `-i` `-c` `-l` the structure would change :
for Regex support : instead of simple string matching it would be replaced with egrep or grep `-E` for extended regular expressions 

for Case-Insensitive Search `-i`: since the script already support case-insensitive matching by converting both the line and search string to lowercase adding -i would be easily implemented 

for count Matches -`c`: a counter variable would track the number of matching lines instead of printing lines the script would output the count at the end

for list filenames `-l`: to make this option available the script would go through each file and print the names of the files contating matches so to make the script able to accept multiple files a new variables would be added to count and to list the files 

### 3-The hardest part to implement was handling the `-v` at the beginning i used match=!$match to invert the match result, but this caused errors because Bash misinterpreted !true and !false as commands to solve this i used an if-else block  


# Task2: Troubleshooting Internal Web Dashboard Connectivity

## Verify DNS Resolution
we check if the `internal.example.com` is resolved correctly both internally and externally

## check internal DNS (`/etc/resolv.conf` file)
`cat /etc/resolv.conf`
![Screenshot from 2025-04-28 19-45-13](https://github.com/user-attachments/assets/2971c1b9-e6d5-4b35-be2e-ed17ea9f6209)



## External DNS (8.8.8.8)

`dig internal.example.com @8.8.8.8`

![Screenshot from 2025-04-28 19-46-53](https://github.com/user-attachments/assets/44cf3f1f-3753-40b3-be1f-bfe4c33414d5)


## Diagnose Service Reachability
To verify whether the internal service `(internal.example.com)` is reachable and properly running, the following steps were performed:

## Test HTTP response with `curl`
using `curl` we check if the service is respoding correctly `curl -I http://internal.example.com`

Check Listening Ports with `netstat netstat -tuln | grep ':80'`

Confirm TCP Connection with telnet `telnet internal.example.com 80`

![Screenshot from 2025-04-28 19-48-42](https://github.com/user-attachments/assets/4dd7ed21-3152-4eb8-869c-590e8116cf0f)


![Screenshot from 2025-04-28 19-54-25](https://github.com/user-attachments/assets/c7d64dcf-be67-4e21-a43c-49b1e9754fe4)


## Possible Causes & Fixes

### 1.DNS Issues

Misconfigured or unreachable internal DNS server. Domain is not known by public DNS servers.

Fixing:

Restart DNS service: `sudo systemctl restart systemd-resolved`

Or update `/etc/resolv.conf` with correct internal DNS.

### 2. Service Issues
he web service may not be running on the correct port. Network configuration issues preventing access to the server.

Fixing:

Check if service is listening on ports using : `netstat -tuln | grep ':80'`

### 3. Network Configuration
Misconfigured firewall or security group rules on the internal server.
we can fix this using:
Check firewall rules: `sudo ufw status`
If ports are closed, that's the issue. Allow traffic: 
`sudo ufw allow 80/tcp` 
`sudo ufw allow 443/tcp`
`sudo ufw enable`
`sudo ufw reload`

![Screenshot from 2025-04-28 19-50-26](https://github.com/user-attachments/assets/304c163b-12ef-4014-a14b-3f9728ca4776)






