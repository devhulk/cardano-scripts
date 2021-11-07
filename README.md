# cardano-scripts

## Cardano Wallet

Go to wallet folder...

Pre-reqs: cardano-wallet must be installed and cardano-node must be running. Allos wallet to sync.

```
nohup ./run-wallet-server.sh &
```

Then you can run the get-info.sh to query network info using the cardano-wallet API. 

```
./get-info.sh
```
