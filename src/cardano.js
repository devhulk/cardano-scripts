const Cardano = require("../../cardanocli-js/index.js")

const cardano = new Cardano({
    network: "testnet-magic 1097911063",
    dir: __dirname + "/../",
    shelleyGenesisPath: __dirname + "/../../cardano/testnet-shelley-genesis.json"

})

module.exports = cardano
