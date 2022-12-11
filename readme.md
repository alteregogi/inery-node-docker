### Dockerize Inery Blockchain

Inery is layer-1 blockchain designed to offer the solution of decentralized database management with the vision to enable a new paradigm for data. It lays the foundation for web3 by seamlessly connecting with systems, applications, and layer-1 networks.

This docker to make sure that user have same environment for their node, and everything run smooth.

### Usage

create docker-compose.yml
you can check my repositories how to install this docker, [inery-task-docker](https://github.com/alteregogi/inery-task-docker/blob/master/readme-en.md)

```yaml
version: '3.9'
services:
  inery-node:
    container_name: inery-node
    image: alteregogi/inery-node
    build:
      context: https://github.com/alteregogi/inery-node-docker.git
      args:
        INERY_ACCOUNT_NAME: REPLACE_WITH_YOUR_INERY_ACC
        INERY_PUBLIC_KEY: REPLACE_WITH_YOUR_PUB_KEY
        INERY_PRIVATE_KEY: REPLACE_WITH_YOUR_PRIV_KEY
        NODE_IP_ADDRESS: REPLACE_WITH_YOUR_IP_ADDR
    command: "tail -f /dev/null"
    privileged: true
    ports:
      - 9010:9010
      - 8888:8888
    volumes:
      - inery-node-docker:/inery-node/
    environment:
      PUID: 1000
      GUID: 1000

volumes:
  inery-node-docker:
    name: inery-node-docker
    driver: local
    driver_opts:
      type: none
      device: "${HOME}/inery/inery-node-vol/"
      o: bind

```

### Parameters

| Parameters           | Function                                                     |
| -------------------- | ------------------------------------------------------------ |
| `INERY_ACCOUNT_NAME` | Your inery account name, this will save as environment variable in the image |
| `INERY_PUBLIC_KEY`   | Your Inery Public Key, this will save as environment variable in the image |
| `INERY_PRIVATE_KEY`  | Your Inery Private Key, this will save as environment variable in the image |
| `NODE_IP_ADDRESS`    | Your Node IP                                                 |
| `ports 9010`         | `9010` peer port                                             |
| `ports 8888`         | `8888` http port for inery RPC                               |

### Inery CLI

To use Inery CLI, or other command inside node you can run this command and edit some params

```shell
docker exec -it inery-node your_command_here
```

example :

```
docker exec -it inery-node cline get info
```

or to run ine.py

```shell
docker exec -it inery-node sh -c "cd ./inery-node/inery.setup/; ./ine.py --help"
```

or you can just bash inside docker

```shell
docker exec -it inery-node bash
```

