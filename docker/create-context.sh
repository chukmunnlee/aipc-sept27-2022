docker context create my-docker-machine \
    --description "my-docker-machine" \
    --docker "host=tcp://128.199.73.182:2376,ca=/home/cmlee/.docker/machine/machines/my-docker-machine/ca.pem,cert=/home/cmlee/.docker/machine/machines/my-docker-machine/cert.pem,key=/home/cmlee/.docker/machine/machines/my-docker-machine/key.pem"