#!/bin/bash

## Token Data and PolicyID
export tokenname="testID7" # mint.json << mints.tokenName
export tokenamount="1" # mints.recieved.quantity
export policyid="a276ba1acb22ad52929975eb01721f832e66ee1df3ec7c15871abf3b" # mints.policyID
export Network="--testnet-magic 1097911063" # request.config

## Mint Wallet Info (UTXO)
export walletPath="../../mintWallet/testTwo/"
export mintaddr="addr_test1vprnpeaw6h2yhcjl0m7pcs6235utpz7kh3vzxhqxd8gka8g4s66y9" #mints.address
export minterFunds="99817867" # mints.unspent
export txhash="bd4c0f37b89681d36e1513b3d7b49523b7d9f08fc6368302f93a5d779989fc6c#0" # mints.unspent.txix
export minterFee="177777" # calculateFee() script after second raw tx build
export minterOutput=$(expr $minterFunds - $minterFee - 2000000)


## Customer Wallet Info (UTXO)

export customerAddr="addr_test1qp3yf90tk5kf2pe7knpwpalwa6acdlpnje84ylc8p9z4fu2um8gd62tj3s2ds5s3ukcmuw6sz63l2p3r7ypxayxkpx0qggz6gu" # payments.customerAddress
export customerOutput="2000000"
