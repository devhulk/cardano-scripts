const cardano = require("./cardano")

const sender = cardano.wallet("PuglyEscrowTest")
const balance = sender.balance()

console.log(
    balance

)
