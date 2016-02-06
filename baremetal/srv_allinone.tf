# Create a device and add it to tf_project_1
resource "packet_device" "allinone" {
  hostname = "allinone"
  plan = "baremetal_3"
  facility = "ewr1"
  operating_system = "centos_7"
  billing_cycle = "hourly"
  project_id = "${packet_project.packet_allinone.id}"


  connection {
        type = "ssh"
        user = "root"
        port = 22
        timeout = "${var.ssh-timeout}"
      }


/* SETUP FIREWALL ON NEW HOST TO ONLY ALLOW FROM YOUR CURRENT INTERNET ACCESS POINT */
   provisioner "remote-exec" {
      inline = [
         "set -e",
         "set -x",
         "export CLIENTIP=${file("whatsmyip.txt")}",
         "echo Restricting access to: $CLIENTIP",
         "/sbin/iptables --flush",
         "/sbin/iptables --delete-chain",
         "/sbin/iptables -P INPUT DROP",
         "/sbin/iptables -P FORWARD DROP",
         "/sbin/iptables -P OUTPUT ACCEPT",
         "/sbin/iptables -A INPUT -i lo -j ACCEPT",
         "/sbin/iptables -A OUTPUT -o lo -j ACCEPT",
         "/sbin/iptables -A INPUT -i team0:0 -j ACCEPT",
         "/sbin/iptables -A OUTPUT -o team0:0 -j ACCEPT",
         "/sbin/iptables -A INPUT -p tcp ! --syn -m state --state NEW -s $CLIENTIP/32 -j DROP",
         "/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT",
         "/sbin/iptables -A INPUT -p tcp --dport 22 -m state --state NEW -s $CLIENTIP/32 -j ACCEPT",
         "/sbin/iptables -A INPUT -p tcp --dport 80 -m state --state NEW -s $CLIENTIP/32 -j ACCEPT",
         "/sbin/iptables -A INPUT -p tcp --dport 5000 -m state --state NEW -s $CLIENTIP/32 -j ACCEPT"
   ]
  }

/* Setup RDO OpenStack */
    provisioner "remote-exec" {
       inline = [
       "set -e",
       "set -x",
       "yum -y update",
       "systemctl stop NetworkManager",
       "yum install -y https://www.rdoproject.org/repos/rdo-release.rpm",
       "yum install -y openstack-packstack",
       "yum -y update",
       "time packstack --allinone --os-cinder-install=n --nagios-install=n --os-ceilometer-install=n",
       ". ./keystonerc_admin",
       "chown root:kvm /dev/kvm",
       "chmod 660 /dev/kvm",
       "useradd -G kvm nova",
       "wget -q http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2.xz",
       "unxz CentOS-7-x86_64-GenericCloud.qcow2.xz ",
       "glance --os-image-api-version 2 image-create --protected True --name CentOS7 --visibility public --disk-format raw --container-format bare --file CentOS-7-x86_64-GenericCloud.qcow2",
       "echo End of section at $(date)"
       ]
     }


}
