# Atlantic Soldity Contracts

This repository contains the solidity contracts that manage the Brandywine Bridge project. The solidity contracts for the Brandywine Bridge are two main categories:

1. The Chainlink Oracle Request Contract
2. The Chainlink Aggregator Contract 

Item 1 is the set of contracts that define the logic of locking Ether on the Ethereum blockchain and sending the user requests to a set, M, number of Chainlink nodes / External Adapters. The responses recieved from the external adapters and Chainlink nodes must come to the same consensus as what the final result on the Elrond Aggregator smart contracts produces. This type of method means that the aggregator conesnsus mechanism is calculated independently on each blockchain - once on Ethereum and once on Elrond. A double consensus method ensures the integrety of having a decentralized system while also managing the need to keep the exact same value between the amount of ETH locked in the Brandywine holding contract to the amount of ESDT bEth minted from the Brandywine Elrond contracts.

While Item 1 is the Ethereum to Elrond bridge, Item 2 covers un-locking Ether, or going from Elrond to Ethereum. This process involves burning the bEth on the Elrond blockchain and unlocking the equivalent ETH on Ethereum. The eth-aggreagtor contract must reach consensus from N out of M Chainlink External Adapter / Oracle Node responses in order for the transaction to be complete. Once the official transaction is complete, a second signal is sent to officially burn the bEth wrapped tokens.

## Tasks

    [] Write Governance Contract
    [] Write Aggregator Contract
    [] Write Atlantic Token Staking Contract

    [] Write ETH Lockup Contract
    [] Write Minter / Burner Contract

    [] Define endpoint architecture for adding more blockchain connections.


## Table of Contents

1. [Getting Started](#Getting-Started)
2. [Testing](#Testing)
3. [Contracts](#Contracts)
4. [Scripts](#Scripts)

## Getting Started


## Testing


## Contracts


## Scripts