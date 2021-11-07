#!/bin/bash

cardano-wallet serve --listen-address 0.0.0.0 --node-socket $HOME/cardano/db/node.socket --testnet $HOME/cardano/testnet-byron-genesis.json --database $HOME/cardano-scripts/wallet/db/
