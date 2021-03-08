_This readme is in progress. More explanation comming on the [Changes I made secion](#changes-i-made-in-hyperledger-caliper)_

_Also more explanation on the network and benchmark configs so you can run them too!_

# Welcome to my benchmark!

This is a benchmark for an example Ethereum Smart Contract using Hyperledger Caliper. There are configurations for 3 different blockchains to do the Benchmark:

- **Ganache:** Simulated local Ethereum Blockchain
- **Geth PoW:** Local Blockchain using the Go-Ethereum official implementation with the consensus algorithm Proof of Work
- **Geth PoA:** Local Blockchain using the Go-Ethereum official implementation with the consensus algorithm Proof of Authority

_"Wait, you included `node_modules/`, are you crazy?_

I did this benchmark using caliper@0.4.2 on a windows machine, and had to tweak a bit the library to make it run. I suggest if you clone this project delete node_modules folder, install dependencies with `npm i` and try to run the benchmark!

If that doesn't work, feel free to use the library I included in the project (I only included the one I changed, however if dependencies are broken jump to where I talk about the changes I made and try to make them yourself on the latest version of caliper).

## Configuration

### Ganache

Refer to Ganache and Truffle docs [here](https://www.trufflesuite.com/) if this is the first time you use them.

Ganache accounts used by Caliper are hardCoded in benchmarks/configGanache.yaml. Therefore you either need to change them with your ganache addresses or generate the same 10 accounts with ganache using the seed `source jewel review offer prosper reform tent carpet cry license hint lottery`

_Note: There accounts are for testing purposes, don't use them with real Ether ;)_

### geth PoW

Run the network like I explain in the other repo and run the command below!

### geth PoA

Run the network like I explain in the other repo and run the command below!

## Running the benchmark

Refer to the official docs to [run it](https://hyperledger.github.io/caliper/).

The big command, including all the config and network files, would be:

- **Ganache:** `npx caliper launch manager --caliper-workspace ./caliperWorkspace/ --caliper-benchconfig benchmarks/configGanache.yaml --caliper-networkconfig networks/networkConfigGanache.json`
- **Geth PoW:** `npx caliper launch manager --caliper-workspace ./caliperWorkspace/ --caliper-benchconfig benchmarks/configGethPOW.yaml --caliper-networkconfig networks/networkConfigGeth.json`
- **Geth PoA:** `npx caliper launch manager --caliper-workspace ./caliperWorkspace/ --caliper-benchconfig benchmarks/configGethPOA.yaml --caliper-networkconfig networks/networkConfigGeth.json`

_NOTE: You can actually run the rounds of PoA with PoW and viceversa, since the network is the same (not at the same time though, just I have in my [ethereum-private-blockchain](https://github.com/fransotodev/geth-private-blockchain) repo 2 nodes that can actually start running a PoW or a PoA network indifferently)._

_However, PoW is CPU intensive and I have a laptop, not a mining farm, so PoW rounds in the benchmark are pretty small (3200tx total) compared with PoA or ganache rounds (13000tx total each)_

## Changes I made in Hyperledger Caliper

### Caliper core

- Just a small one to make `npx caliper bind` command work on a windows machine. Already submitted a PR to their repo.

### Ethereum connector

- Mapped request params (they were not named as they were later used)

- Hardcoded a gas limit value (This is not a value included in my compiled smart contract json, not sure if it should even be included).
