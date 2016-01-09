provider "packet" {
        /*auth_token = "${var.packet_auth_token}"*/
        auth_token = "GpWV9vPkXoK4HXnrSxSx225s2KTYvUR6"
}

provider "dnsimple" {
    token = "tKyIqEyOeGPXuetyC5raKAyUr6YLPHPz"
    email = "jim.leitch@sunningdale.nl"
}
