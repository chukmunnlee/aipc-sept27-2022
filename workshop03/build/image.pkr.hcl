
source digitalocean codeserver {
    api_token = var.DO_token
    image = var.DO_image
    size = var.DO_size
    region = var.DO_region
    snapshot_name = "codeserver"
    ssh_username = "root"
}

build {
    sources = [
        "source.digitalocean.codeserver"
    ]
}