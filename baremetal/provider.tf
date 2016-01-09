provider "packet" {
        auth_token = "${var.packet_auth_token}"
        }

        # Create a project
resource "packet_project" "packet_allinone" {
        name = "Packet All-In-One OpenStack"
}
