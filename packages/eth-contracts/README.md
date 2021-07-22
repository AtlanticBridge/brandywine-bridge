# Atlantic Soldity Contracts

This repository contains the solidity contracts that manage the Brandywine Bridge project. The solidity contracts for the Brandywine Bridge are two main categories:

1. The Chainlink Oracle Request Contract
2. The Chainlink Aggregator Contract 

Item 1 is the set of contracts that define the logic of locking Ether on the Ethereum blockchain and sending the user requests to a set, M, number of Chainlink nodes / External Adapters. The responses recieved from the external adapters and Chainlink nodes must come to the same consensus as what the final result on the Elrond Aggregator smart contracts produces. This type of method means that the aggregator conesnsus mechanism is calculated independently on each blockchain - once on Ethereum and once on Elrond. A double consensus method ensures the integrety of having a decentralized system while also managing the need to keep the exact same value between the amount of ETH locked in the Brandywine holding contract to the amount of ESDT bEth minted from the Brandywine Elrond contracts.

While Item 1 is the Ethereu to Elrond bridge, Item 2 covers un-locking Ether, or going from Elrond to Ethereum. This process involves burning the bEth on the Elrond blockchain and unlocking the equivalent ETH on Ethereum. The eth-aggreagtor contract must reach consensus from N out of M Chainlink External Adapter / Oracle Node responses in order for the transaction to be complete. Once the official transaction is complete, a second signal is sent to officially burn the bEth wrapped tokens.

## Tasks

    [] Write Governance Contract
    [] Write Aggregator Contract
    [] Write Atlantic Token Staking Contract

    [] Write ETH Lockup Contract
    [] Write Minter / Burner Contract


## Table of Contents

1. [Governance Contracts](#Governance-Contracts)
    - [Proposers](#Proposers)
    - [Voters](#Voters)
2. [Chainlink Oracle Contracts](#Chainlink-Oracle-Contracts)
    - [Aggregator](#Aggregator)

## Governance Contracts

There are several updates that can be changed through community governance. The list of all the governance options are listed in the table below. The governance mechanism is split up between proposers and voters. 

| Item              | Description                                      |
| ----------------- | ------------------------------------------------ |
| Job Specification | The Oracle job that triggers an External Adapter |

### Proposers

Proposals can happen by any account that is part of the ecosystem of the Brandywine Bridge. Utilmately, this is like an "email signup" where an account simply needs to connect to the Brandywine Bridge through a Web3 interace and can then propose an upgrade to the system. 

### Voters
Voters are accounts that have staked Atalantic tokens in the governance contract. These accounts can vote on proposals made to the system. For a proposal to be implemented, 75% of the total weighted number of valid voters must approve of the proposition. There is also a block limit, B, where this approval process must be voted on before the rundown time. If the rundown time has been reach without the 75% weighted consensus having been met, the propsoal is refused and removed from the proposal list.

Ensuring that proposals are implemented, a decentralized autonomous organization (DAO) stucture manages the governance requests. If a propsal has been accepted, the DAO authority contract automatically implements the changes.


## Chainlink Oracle Contracts

This section outlines the methodology and development structure of the contracts that are utilized for the Chainlink Oracle solution. When a user sends a request to transfer their Ethereum to Elrond, the same request gets sent out to every, M, Chainlink Oracle Jobs. To meet consensus, N number of oracle requests must match exactly in order for the bETH to be minted.

The amount allowed to be minted by an external adapter is limited to the amount of Ether (or maybe Atlantic tokens) staked. This is to incentivize the external adapter operators to be good actors. If an external adapter (EA) is found to be a bad actor, the staked tokens are slashed and the EA is removed from the approved Oracle and Job Specification list.

**insert diagram here**
User Request => Bridge 2 Elrond Contract => Send Multiple Chainlink Oracle Requests => Aggregate Responses to verify if tokens were actually minted.

### Aggregator

The aggregator contract resolves the incoming requests to unlock ETH held in the holding contract. This contrcat does not get invoked when locking up ETH to be minted on the Elrond blockchain.
A separate aggregator contract to mint the bETH on Elrond is used.

The goal of the aggregator contract is to manage the efficacy of a decentralized external adapter system


## Writing Upgradeable Contracts

Check: https://docs.openzeppelin.com/upgrades-plugins/1.x/writing-upgradeable

## Proxy Upgrade Pattern

Check: https://docs.openzeppelin.com/upgrades-plugins/1.x/proxies



