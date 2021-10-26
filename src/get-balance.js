const cardano = require("./cardano")

const sender = cardano.wallet("PuglyEscrowTest")

console.log(
    sender.balance()
)
