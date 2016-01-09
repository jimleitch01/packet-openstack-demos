# packet-openstack-demos

Deploying OpenStack on "Packet.Net" bare metal hosting using Terraform

N.B. These instruction were made on Mac, and should run with no changes in Linux. Windows should be awesome too, but
you're on your own for that gig.

### Pre-requisites

- Terraform
- Git
- Packet.Net account, with API token
- Your ssh public key uploaded to Packet.Net via web interface


```
export TF_VAR_packet_auth_token=YOUR_API_TOKEN_HERE
mkdir stuffz
cd stuffz
git clone git@github.com:jimleitch01/packet-openstack-demos.git
cd packet-openstack-demos/baremetal
```

User "terraform plan" to check for syntax errors
```
terraform plan
```

No errors ? All set ! This will take about 20 minutes
```
time terraform apply
```

This will output your admin user password:
```
ssh root@$(terraform show | grep network.0.address | awk '{print $3}') cat keystonerc_admin | grep PASSWORD | cut -f2 -d"="
```

This will output your demo user password:
```
ssh root@$(terraform show | grep network.0.address | awk '{print $3}') cat keystonerc_demo | grep PASSWORD | cut -f2 -d"="
```

If you are on Mac, open the OpenStack admin page like this:
```
open -a Safari http://$(terraform show | grep network.0.address | awk '{print $3}')
```

For any other OS paste this URL into your favorite browser:
```
echo http://$(terraform show | grep network.0.address | awk '{print $3}')
```

#### Ready To Rock !!!


You can now play around to your heart's content.

make sure to kill your hosts when you are done:

```
terraform destroy
```
