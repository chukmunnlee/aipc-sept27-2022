data digitalocean_ssh_key mykey {
    name = "aipc"
}

data docker_image fortune {
    name = "chukmunnlee/fortune:v2"
}

resource digitalocean_ssh_key abc {
    name = "abc"
    public_key = file("/opt/tmp/abc.pub")
}

/*
resource docker_container fortune_container {
    count = 3
    name = "fortune-${count.index}"
    image = data.docker_image.fortune.id
    ports {
        internal = 3000
    }
} */    

resource digitalocean_droplet mydroplet {
    name = "mydroplet"
    image = var.DO_image
    region = var.DO_region
    size = var.DO_size
    //ssh_keys = [ data.digitalocean_ssh_key.mykey.id ]
    ssh_keys = [ digitalocean_ssh_key.abc.id ]

    connection {
        // ssh -i /opt/tmp/aipc root@IP
      type = "ssh"
      user = "root"
      private_key = file("/opt/tmp/abc")
      host = self.ipv4_address
    }
    provisioner remote-exec {
        inline = [
            "apt update",
            "apt install -y nginx",
            "systemctl enable nginx",
            "systemctl start nginx",
        ]
    }
}

resource local_file root_at_ip {
    content = ""
    filename = "root@${digitalocean_droplet.mydroplet.ipv4_address}"
}

resource local_file readme {
    content = templatefile("readme.tftpl", { 
        ip = digitalocean_droplet.mydroplet.ipv4_address
    })
    filename = "readme.txt"
}


output mydroplet_ip {
    value = digitalocean_droplet.mydroplet.ipv4_address
}

output mykey_fingerprint {
    description = "my ssh key fingerprint"
    value = data.digitalocean_ssh_key.mykey
}

output fortune_digest {
    description = "fortune digest"
    value = data.docker_image.fortune.repo_digest
}

/*
output fortune_ports {
    value = join(",", [ for p in docker_container.fortune_container[*]: p.ports[0].external ])
}
*/