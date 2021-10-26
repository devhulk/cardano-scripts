const cardano = require("./cardano")

const createWallet = name => {

    const payment = cardano.addressKeyGen(name)
    const stake = cardano.stakeAddressKeyGen(name)
    cardano.stakeAddressBuild(name)
    cardano.addressBuild(name, {
        paymentVkey: payment.vkey,
        stakeVkey: stake.vkey
    })

    return cardano.wallet(name)
}

createWallet("PuglyEscrowTest2")
