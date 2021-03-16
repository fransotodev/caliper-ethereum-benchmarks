_This readme is in progress. More explanation comming on the [Changes I made secion](#changes-i-made-in-hyperledger-caliper)_

_Also more explanation on the network and benchmark configs so you can run them too!_

# Welcome to my benchmark!

This is a benchmark for an example Ethereum Smart Contract using Hyperledger Caliper. There are configurations for 3 different blockchains to do the Benchmark:

- **Ganache:** Simulated local Ethereum Blockchain
- **Geth PoW:** Local Blockchain using the Go-Ethereum official implementation with the consensus algorithm Proof of Work
- **Geth PoA:** Local Blockchain using the Go-Ethereum official implementation with the consensus algorithm Proof of Authority


## Configuration

### Ganache

Refer to Ganache and Truffle docs [here](https://www.trufflesuite.com/) if this is the first time you use them.

Ganache accounts used by Caliper are hardCoded in benchmarks/configGanache.yaml. Therefore you either need to change them with your ganache addresses or generate the same 10 accounts with ganache using the seed `source jewel review offer prosper reform tent carpet cry license hint lottery`

_Note: There accounts are for testing purposes, don't use them with real Ether ;)_

### geth PoW

Run the network like I explain in [my other repo](https://www.github.com/fransotodev/geth-private-blockchain) and run the command below!

### geth PoA

Run the network like I explain in [my other repo](https://www.github.com/fransotodev/geth-private-blockchain) and run the command below!

## Deploy the Smart contract

I provided ganache and geth configs (geth based on [my other repo](https://www.github.com/fransotodev/geth-private-blockchain)) for truffle , just run:

- Ganache: `truffle migrate --network development`
- Geth: `truffle migrate --network geth`

After that you will need to modify the contract build file to specify a gas big enough for caliper not to complain. You can do it manually or run `node scripts/prepareBuildedContract.js` (it sets it to 300000).

## Running the benchmark

Refer to the official docs if you have doubts [running it](https://hyperledger.github.io/caliper/).

The big command, including all the config and network files, would be:

- **Ganache:** `npx caliper launch manager --caliper-workspace ./caliperWorkspace/ --caliper-benchconfig benchmarks/configGanache.yaml --caliper-networkconfig networks/networkConfigGanache.json`
- **Geth PoW:** `npx caliper launch manager --caliper-workspace ./caliperWorkspace/ --caliper-benchconfig benchmarks/configGethPOW.yaml --caliper-networkconfig networks/networkConfigGeth.json`
- **Geth PoA:** `npx caliper launch manager --caliper-workspace ./caliperWorkspace/ --caliper-benchconfig benchmarks/configGethPOA.yaml --caliper-networkconfig networks/networkConfigGeth.json`

_NOTE: You can actually run the rounds of PoA with PoW and viceversa, since the network is the same (not at the same time though, just I have in my [ethereum-private-blockchain](https://github.com/fransotodev/geth-private-blockchain) repo 2 nodes that can actually start running a PoW or a PoA network indifferently)._

_However, PoW is CPU intensive and I have a laptop, not a mining farm, so PoW rounds in the benchmark are pretty small (3200tx total) compared with PoA or ganache rounds (13000tx total each). Feel free to modify those rounds_

## Problems running hyperledger Caliper?

* Did you set the gas field in your smart Contract build file? Remember that you must set it every time you compile and migrate it

* If you are using a windows machine and following the caliper docs, `caliper-cli bind` command won't work because it tries to launch a npm install command, but on windows it would be npm.cmd install (already submitted a PR with a fix for that one)
