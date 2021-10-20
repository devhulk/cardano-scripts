const cardano = require("./cardano")
const getPolicyId = require("./get-policy-id")
const country_pugs_all = require("../metadata/country_pugs/_metadata.json") // assets

const country_pugs = country_pugs_all.slice(0,25)
const wallet = cardano.wallet("PuglyEscrowTest")

const {policyId: POLICY_ID, mintScript} = getPolicyId()



// Reformat base metadata and delete unneeded fields
const metadata_assets = country_pugs.reduce((result, pug) => {

    const name = pug.name.toUpperCase()

    const PUG_ID = name // ASSET_ID

    const pug_metadata = {
        ...pug
    }

    // DELETE IN PRODUCTION MINT
    delete pug_metadata.dna
    delete pug_metadata.name
    delete pug_metadata.src

    // KEEP FOR PRODUCTION MINT
    delete pug_metadata.imageLink
    delete pug_metadata.image

    return {
        ...result,
        [PUG_ID]: pug_metadata
    }
}, {})

// console.log(metadata_assets)

// Create transaction metadata

const tx_metadata = {
    721: {
        [POLICY_ID]: {
            ...metadata_assets
        }
    }
}

const txOut_amount = country_pugs.reduce((result, pug) => {

    const PUG_ID = POLICY_ID + "." + pug.name.toUpperCase()
    result[PUG_ID] = 1
    return result

}, {
    ...wallet.balance().amount
})

// console.log(txOut_amount)
// console.log(wallet.balance().value)

// console.log(txOut_amount)

const mint_actions = country_pugs.map(pug => ({ action: "mint", amount: 1, token: POLICY_ID + "." + pug.name.toUpperCase()}))

console.log(mint_actions[0])

// Define Transaction
// TODO: Refund wallet and test with 3.0.0 cli js. Currently wallet output is undefined, I think its because the wallet isn't funded and I cant get more until tomorrow.

const tx = {
    txIn: wallet.balance().utxo,
    txOut: [
        {
            address: wallet.paymentAddr,
            amount: txOut_amount, // was amount
        }
    ],
    mint: mint_actions,
    tx_metadata,
    witnessCount: 2
}

// Build transaction

const buildTransaction = (tx) => {

    const raw = cardano.transactionBuildRaw(tx)
    const fee = cardano.transactionCalculateMinFee({
        ...tx,
        txBody: raw
    })
    console.log(fee)

    tx.txOut[0].value.lovelace -= fee

    return cardano.transactionBuildRaw({ ...tx, fee })
}

const raw = buildTransaction(tx)

// Sign transaction

const signTransaction = (wallet, tx) => {

    return cardano.transactionSign({
        signingKeys: [wallet.payment.skey, wallet.payment.skey],
        txBody: tx
    })
}

const signed = signTransaction(wallet, raw)

// Submit transaction

const txHash = cardano.transactionSubmit(signed)

console.log(txHash)



