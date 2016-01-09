# packet-openstack-demos

Deploying OpenStack on "Packet.Net" bare metal hosting using Terraform

N.B. These instruction were made on Mac, and should run with no changes in Linux. Windows should be awesome too, but
you're on your own for that gig.

### Pre-requisites

- Terraform
- Git
- Packet.Net account, with API token


```
TF_VAR_packet_auth_token=YOUR_API_TOKEN_HERE
mkdir stuffz
cd stuffz
git clone git@github.com:jimleitch01/packet-openstack-demos.git
```
