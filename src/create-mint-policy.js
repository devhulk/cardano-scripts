const fs = require("fs")
const cardano = require("./cardano")

const wallet = cardano.wallet("PuglyEscrowTest")

const { slot } = cardano.queryTip()
const SLOTS_PER_EPOCH = 5 * 24 * 60 * 60 // 432,000

// NON TIME Locked Mint Script
// const mintScript = {
//     keyHash: cardano.addressKeyHash(wallet.name),
//     type: "sig"
// }


// TIME Locked Mint Script
const mintScript = {
    type: "all",
    scripts: [
        {
            slot: slot + (SLOTS_PER_EPOCH * 73),
            type: "before"
        },
        {
            keyHash: cardano.addressKeyHash(wallet.name),
            type: "sig"
        }
    ]
}

fs.writeFileSync(__dirname + "/mint-policy.json", JSON.stringify(mintScript, null, 2))
fs.writeFileSync(__dirname + "/mint-policy-id.txt", cardano.transactionPolicyid(mintScript))
