
# Config file for INFRA network

# To avoid authentication tokens leaking into GitHub, this must be set via evironment variable TF_VAR_packet_auth_token
variable "packet_auth_token" {
  description = "Packet auth token"
}

variable "num-allinone-servers" {
  description = ""
  default = "1"
}

variable "num-cont-servers" {
  description = "Openstack Controller"
  default = "0"
}

variable "num-comp-servers" {
  description = "Openstack Compute"
  default = "0"
}

variable "num-stor-servers" {
  #Win2012
  description = "Openstack Storage"
  default = "0"
}

variable "ssh-timeout" {
  description = "ssh timeout"
  default = "60s"
}

variable "default-image-type" {
  description = "serve image to use for instance"
  default = "CentOS7"
}

variable "my-toolbox-yums" {
  description = "serve image to use for instance"
  default = "puppet telnet bind-utils mlocate tcpdump crudini wget unzip"
}
