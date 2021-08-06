# Atlantic Bridge Smart Contracts

The structure of the Ethereum smart contracts for the Brandywine bridge is to modularize [1] The Governance Contract, [2] The Chailink Oracle Request Contract and [3] The Lockup Contract.

## Table of Contents

1. [Bridge](#Bridge)
2. [Chainlink Request](#Chainlink-Request)
3. [Aggregator](#Aggregator)
4. [Governance](#Governance)



## Bridge

The Bridge Contract encapsulates the methods and data used to store information about the Chainlink nodes, Oracles, Job Specifications and other generic bridge information. In addition, this contract manages Access control between the [governance contract](#Governance) and the [chainlink request contract](#Chainlink-Request).

The Bridge contracts on Ethereum and Elrond smart contracts work independently from each other and are solely linked through the Chainlink node operators. Having indepenent governance between blockchains allows for the smart contract structure to tailer towards the needs of each respective blockchain. It also helps keep an agnostic and abstract approach, allowing for each blockchain's governance contracts to store the available links to all the blockchain bridges available in the network.

#### Ethereum to Elrond

Bridge contracts are based in Ethereum due to the connection structure of the Chainlink node connection being dependent to EVM machines. To be agnostic and maintain decentralization, there is a need to [1] aggregate responses from external adapters on the Chainlink nodes and [2] aggregate responses from Chainlink nodes in the smart contracts.

#### Elrond to Ethereum

Because the Chainlink nodes are directly linked to the Ethereum blockchain and not the Elrond blockchain (currently), it is necessary to utilize external initiators to trigger Chainlink node operations. 

For more information on the Elrond smart contracts and structure, please refer to the README in the erd-contracts package.

### Oracles

The Atlantic Bridge utilizes Chainlink nodes to perform specific job instructions both internal and external adapters. The practice here is to have one Chainlink node connected to one oracle contract.

Oracle Contracts are tied to Node operators. We want to limit the maximum usage of each of these in order to maintain security measures and as an extra layer of security for any external adapters that are might trying to hack or distrub the network.

All Chainlink transactions are funneled through the Chainlink Oracle contracts. Oracle contracts must be approved through the Governance DAO contract where the participants may approve, deny or remove Chainlink nodes.

### Job Specifications

The job specifications are the identifiable identifiction numbers associated with a unique Chainlink Oracle. The job specifications should contain the specific information about which blockchain is associated with them.

## Chainlink Request

The Chainlink Request Contract collects oracle and job information from the [bridge contract](#Bridge) to process and submit jobs to a set of Chainlink nodes. The number of oracle jobs (`M`) to be submitted is the minimum number of oracles required for the aggregator contract to receive and to be effectively used to come to a minting consensus.

### Aggregator

The aggregator contract resolves the incoming requests to unlock ETH held in the holding contract. This contrcat does not get invoked when locking up ETH to be minted on the Elrond blockchain.
A separate aggregator contract to mint the bETH on Elrond is used.

The goal of the aggregator contract is to manage the efficacy of a decentralized external adapter system

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