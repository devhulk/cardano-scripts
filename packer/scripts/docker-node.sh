#!/bin/bash

apt-get update -y
apt-get install curl automake build-essential pkg-config libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make g++ tmux git jq wget libncursesw5 libtool autoconf -y

mkdir -p $HOME/.local/bin
cd $HOME/.local/bin || { echo "Couldn't change dir to .local/bin"; exit 1; }

curl -O https://hydra.iohk.io/build/7739415/download/1/cardano-node-1.30.1-linux.tar.gz

tar -xvf cardano-node-1.30.1-linux.tar.gz

export PATH="$HOME/.local/bin/:$PATH"
echo 'export PATH="$HOME/.local/bin/:$PATH"' >> ~/.bashrc

source $HOME/.bashrc

cardano-cli --version
cardano-node --version

mkdir -p $HOME/cardano/db

cd $HOME/cardano || { echo "Couldn't change dir to cardano dir"; exit 1; }
export CARDANO_NODE_SOCKET_PATH="$HOME/cardano/db/node.socket"
echo 'export CARDANO_NODE_SOCKET_PATH="$HOME/cardano/db/node.socket"' >> ~/.bashrc


get_testnet_files () {
    curl -O -J https://hydra.iohk.io/build/7654130/download/1/testnet-topology.json
    curl -O -J https://hydra.iohk.io/build/7654130/download/1/testnet-shelley-genesis.json
    curl -O -J https://hydra.iohk.io/build/7654130/download/1/testnet-config.json
    curl -O -J https://hydra.iohk.io/build/7654130/download/1/testnet-byron-genesis.json
    curl -O -J https://hydra.iohk.io/build/7654130/download/1/testnet-alonzo-genesis.json
}

get_mainnet_files () {
    curl -O -J https://hydra.iohk.io/build/7370192/download/1/mainnet-config.json
    curl -O -J https://hydra.iohk.io/build/7370192/download/1/mainnet-byron-genesis.json
    curl -O -J https://hydra.iohk.io/build/7370192/download/1/mainnet-shelley-genesis.json
    curl -O -J https://hydra.iohk.io/build/7370192/download/1/mainnet-alonzo-genesis.json
    curl -O -J https://hydra.iohk.io/build/7370192/download/1/mainnet-topology.json
}

if [ $CardanoNetwork == "testnet" ]; 
then
    echo "Testnet config starting..."
    get_testnet_files
else
    echo "Mainnet config starting..."
    get_mainnet_files
fi

touch run-node.sh

chmod +x ./run-node.sh

echo "#!/bin/bash" >> run-node.sh
echo "cardano-node run \\" >> run-node.sh
echo "--topology $HOME/cardano/$CardanoNetwork-topology.json \\" >> run-node.sh
echo "--database-path $HOME/cardano/db \\" >> run-node.sh
echo "--socket-path $HOME/cardano/db/node.socket \\" >> run-node.sh
echo "--host-addr 0.0.0.0 \\" >> run-node.sh
echo "--port 1337 \\" >> run-node.sh
echo "--config $HOME/cardano/$CardanoNetwork-config.json" >> run-node.sh

cat ./run-node.sh

touch query-tip.sh
chmod +x ./query-tip.sh

if [ $CardanoNetwork == "testnet" ]; 
then
    echo "#!/bin/bash" >> query-tip.sh
    echo "cardano-cli query tip --testnet-magic 1097911063\\" >> query-tip.sh
else
    echo "#!/bin/bash" >> query-tip.sh
    echo "cardano-cli query tip --mainnet\\" >> query-tip.sh
fi


