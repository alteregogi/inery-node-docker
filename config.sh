#!/bin/sh

sed -e "s/accountName/$INERY_ACCOUNT_NAME/g" -i ./inery-node/inery.setup/tools/config.json
sed -e "s/publicKey/$INERY_PUBLIC_KEY/g" -i ./inery-node/inery.setup/tools/config.json
sed -e "s/privateKey/$INERY_PRIVATE_KEY/g" -i ./inery-node/inery.setup/tools/config.json
sed -e "s/IP/$NODE_IP_ADDRESS/g" -i ./inery-node/inery.setup/tools/config.json