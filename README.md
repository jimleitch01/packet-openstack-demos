# packet-openstack-demos

Deploying OpenStack on "Packet.Net" bare metal hosting using Terraform

I'm using RedHat's RDO QuickStart (https://www.rdoproject.org/install/quickstart/)

This QuickStart will get a demo OpenStack environment running on baremetal hosting as provided by http://packet.Net

No need to repurpose old hardware and you won't have to tidy your garage.



N.B. These instruction were made on Mac, and should run with no changes in Linux. Windows should be awesome too, but
you're on your own for that gig. (anyone who gets this working on a Windows client, please feel free to send the instructions for me to update this)

### Pre-requisites

- Terraform
- Git
- Packet.Net account, with API token
- Your ssh public key uploaded to Packet.Net via web interface


```
export TF_VAR_packet_auth_token=YOUR_API_TOKEN_HERE
mkdir stuffz
cd stuffz
git clone https://github.com/jimleitch01/packet-openstack-demos.git
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
All done ? Ok, let's get logged in


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

## Next steps

- Multi Node OpenStack
- Fully Populated CI/CD environment
- Take a well deserved break
