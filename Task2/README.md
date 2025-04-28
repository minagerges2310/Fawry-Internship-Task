# Troubleshooting Internal Web Dashboard Connectivity

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
