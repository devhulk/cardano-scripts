#!/bin/env bash
export Network="--testnet-magic 1097911063"
export tokenname="NFT1"
export tokenamount="1"
export fee=$(cardano-cli transaction calculate-min-fee --tx-body-file matx.raw --tx-in-count 1 --tx-out-count 1 --witness-count 2 --mainnet --protocol-params-file protocol.json | cut -d " " -f1)
export output="0"
export ipfs_hash="QmaFHh4xAoykpa49xTkrrE9h2ojHhC7juvo8Zbed1HAhPA"
export address="addr_test1vz4ldajvl0gxdax4qt8wgvzexwvc2utq9w2nkepejdhztxcp930zx"
export slotnumber="41330560" # replaced after step 6
export script="policy/policy.script"
export txhash="ce67f687802c8644cfe08155c3d20f382dc53ba0d80870de420d16d3f95c3481"
export txix="0"
export funds="10000000"
export policyid=$(cat policy/policyID)
export output=$(expr $funds - $fee)
