# Brandywine Bridge V1
### Whitepaper
### July 2021

[1. Introduction](#introduction)

[2. Architectural Overview](#architectural-overview)

[3. Contract Overview](#contract-overview)

[4. Bridge Integrity And Safety](#bridge-integrity-and-safety)

[5. Validators](#validators)

[6. Governance](#governance)

[7. Future Developments](#future-developments)

[8. Potential Use Cases](#potential-use-cases)

[9. Formal Definitions](#formal-definitions)

### Abstract
An overview of the theory behind the Brandywine Bridge; its implementation, features, and outlook.

### Introduction

#### What is the goal of the Brandywine Bridge?
The initial goal of the Brandywine Bridge is to create a means of transferring assets seamlessly between the Elrond and Ethereum blockchains. We aim to create a infrastructure that is fully decentralised, scalable, and easy to use. The architecture behind the Bridge can then be used to set up connections to other blockchains, with a longer term vision of creating an internet of blockchains.

#### What does it do?
The bridge allows for the transfer of on-chain assets between different blockchains, by locking assets in a smart contract on their native chain and minting a token on the target chain. The integrity and safety of the bridge is ensured by using Chainlink coupled with a consensus mechanism, described in X.X.

#### How is it different from other bridges?
Many other cross blockchain bridges work by connecting nodes from each of the participating blockchains. Typically, a set of nodes, or validators, on one blockchain listen for events on the other. A consensus mechanism can then take place between the validators on either of the chains, and if consensus is reached, tokens can be minted or burned as required.

The Brandywine Bridge is different. Instead of using validator nodes 

#### Is it more scalable? Is it more flexible? Research

#### What are the main features? 
•	Atlantic Token – A governance token used to vote on protocol changes.
•	Bridge Aggregators – Contracts for aggregating transfer data.
•	Chainlink validators – Responsible for receiving transaction requests.

### Architectural Overview

The diagram below describes the high-level architecture of the Brandywine Bridge.

[Architectural Overview](architectural_overview.png)

#### User Journey
In this example we examine the journey of an Ethereum user’s request to transfer 10 Eth to 10 bEth on the Elrond chain, from the web application to completion.

**Making a request**: A transfer request is made by the user by sending 10 Eth along with the user’s address on the Elrond chain to the Ethereum Holding contract.

**Initiating the transaction**: The Holding contract/Bridge Aggregator selects a number of Chainlink validator’s to submit the information about the transaction to the Bridge Aggregator contract on the Elrond chain.

**Consensus**: Once the Elrond Bridge Aggregator receives the data from all of the validators, or a certain number of blocks have expired since it received the first message, a consensus is calculated.

**Success**: If more than two thirds of validators are in agreements, the transaction is deemed successful. The Bridge Aggregator contract calls a contract to mint the bEth.

**Failure**: If consensus is not reached, the transfer is deemed a failure, and the deposit is returned to the user for resubmission.

### Contract Overview

An overview of the internal workings of the contracts involved in the bridge (not governance). Mainly the bridge aggregator, holding, and minting/burning contracts.

### Bridge integrity and safety

Arguably the most important feature of any blockchain architecture is its integrity; the idea that malicious actors can’t jeopardise the system, causing material loss to participants. In the context of cross chain bridges, this means ensuring that the exact amount of any asset deposited/withdrawn on one chain, is minted/burned on the other, and sent to the correct receiver. The Brandywine Bridge achieves this by implementing a Consensus of Price mechanism.

#### Consensus of Price
When a transfer request is made to the Bridge Aggregator/Holding contract, N number of validators are selected from the list of registered validators stored in the contract. Each validator is sent information about the total value of the transfer T, the amount they are assigned to validate (V=N/T), the address A where funds are to be received on the target chain, as well as a unique transaction ID. Each validator is then tasked with sending this information to the Bridge Aggregator contract on the target chain.
When the aggregator contract on the target chain receives its first message with a new unique transaction ID, it saves this and waits for further messages (We could create new contract for each transaction?). The aggregator will know in advance how many messages to wait for, as this is value, N, is voted on by governance. Once the aggregator has received all messages or B number of blocks have passed since the first message was received, it checks the messages. If a consensus of 2/3 is reached by the validators on V, T, and A, then the transfer is successful, and funds can be minted/released on the target chain.

#### What if a validator reports a false V, T, or A?
If a validator reports false data, then a percentage of their stake will be slashed. A slashing constant Sc can be determined through governance, with the overall amount slashed S determined by a formula, where S ∝ ScSt. Where St is the number of times an actor has reported false information. A number of strikes Nst can be determined through governance, where going beyond this limit will cause the actor to be removed from the list of approved validators.

#### What if not all messages are received after B number of blocks?
It is more likely that a message is not received due to loss of connection to the internet rather then malicious acting. Therefore, to encourage participation by validators no slashing occurs when messages are not transmitted within B.

###### How are validators chosen for each transfer?
For any transfer the probability of being chosen as a validator is determined by the following formula, where:
K is the size of a validators stake,
L is the longevity that they have been a validator,
C is a constant determined through governance,
P is the probability of being chosen

#### Determining N
A formula/voting mechanism for determining the number of validators per transfer.

#### Determining B
A formula/voting mechanism for determining after how many blocks of a message being received that messages should be processed.

### Validators
When discussing the Brandywine Bridge, a validator is an operator of a Chainlink node responsible for relaying transfer data between blockchains. To validate transfers in any particular direction, i.e. from Eth -> bEth on the Elrond chain, the validator must submit a stake to the native blockchain, in this example, Ethereum. 
To register as a validator, anyone can call the registerValidator method on the Bridge Aggregator contract, specifying information about their Chainlink node (need more information on specifics here), along with a stake that is held by the Holding contract. The stake is used as a source of collateral by the Bridge, which can be slashed when malicious acting occurs. The unregisterValidator method can also be called to remove the caller from the validator register, the users stake is returned once all validations they are involved with have been resolved.

#### Staking
There is a minimum stake amount that is set at the governance level, this to ensure that bad actors cannot register large quantities of Chainlink nodes cheaply. The size of the stake and the longevity which it is held increase the chances of the validator being selected in the consensus process. This mechanism encourages greater participation over longer periods of time. The formula which determines a validators chance of being selected is described in X.X ‘Determining Validator Selection’. 

#### Rewards
Validators earn rewards for each successful transfer they validate, as determined by the Bridge Aggregator contract. Rewards are a fee paid in the native cryptocurrency of the source blockchain by the requester of the transfer on deposit of funds. Fees are calculated by the following formula, which is determined by the congestion on the Bridge and by governance variables:

INSERT FORMULA

If a transfer does not complete for whatever reason the fee is returned along with the original deposit.

#### Stake Pools
Validators can run stake pools to increase the size of their stake and therefore the likelihood of being chosen for validating a transfer, earning them more rewards. Anyone can designate funds to a validators stake pool and earn staking rewards themselves. This encourages more staking participation, as it means not all participants have to run Chainlink nodes. The validator can also set a percentage of the reward they will collect from participants for running the node, increasing the rewards for themselves and thus also still incentivising agents to become validators. This will create a market effect whereby validators are competing for further participant stakes, while also making it profitable for themselves to do so.

To set up a stake pool, a validator must be a registered validator in the Bridge Aggregator contract, have validated a minimum number of transfers as determined by the community, and meet the minimum stake amount for a pool. Once these conditions are met they can call the registerStakePool method on the Bridge Aggregator contract, this will generate a separate contract for the stake pool where the stake pool owner can register and manage participants.

### Governance
An overview of the governance, the Atlantic token, voting, the process of voting and how it works, etc.

### Launch
Before the launch of the project there will a funding period where validators and stake participants can register. If enough validators have been registered before launch the Bridge can begin fully decentralised.

Alongside these validators an Atlantic Validator Node will be created at launch, this is essentially a centralised node run by the Atlantic Organisation. This will be used if the project is not fully decentralised at launch, but also will remain operational past this point as a centralised alternative. Given the Atlantic Node is centralised it will be quicker at processing transfers between chains, and will be useful for users who are happy to trust a third party for sake of speed and cost.

(This section needs more information about launch)

### Future developments
An overview of how we can easily integrate more blockchains. We will have to design the current framework with this in mind.

### Potential use cases
Potential use cases for the Brandywine Bridge to inspire developers who want to use it in their applications. Similar to the use cases section of the Ethereum white paper.

### Formal Definitions

A list of formal definitions outlining the key terms used in this whitepaper and the Brandywine ecosystem, sorted alphabetically.

**Atlantic token** – The governance token for the Brandywine Bridge.

**bEth** – A token representing Eth with one to one parity on a non-native blockchain.

**Bridge Aggregator** - 

**Consensus of Price** – Consensus mechanism where price and address data is used to validate a transaction.

**Holding contract** –

**Source chain** – The blockchain where a user makes an initial deposit.

**Transfer request** – A call to the deposit function on the Bridge Aggregator/Holding contract, along with an address to send funds to on the target chain.

**Target chain** – The blockchain where a user hopes to receive funds, after a deposit is made on their native chain.

**Validator** – The operator of a Chainlink node used to pass transaction information between two blockchains.
