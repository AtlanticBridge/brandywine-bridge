# Atlantic Bridge Smart Contracts


## Table of Contents

1. [Bridge](#Bridge)
2. [Chainlink Request](#Chainlink-Request)
3. [Governance](#Governance)



## Bridge

The Bridge Contract encapsulates the methods and data used to store information about the Chainlink nodes, Oracles, Job Specifications and other generic bridge information. In addition, this contract manages Access control between the [governance contract](#Governance) and the [chainlink request contract](#Chainlink-Request).

### Oracles

The Atlantic Bridge utilizes Chainlink nodes to perform specific job instructions both internal and external adapters. The practice here is to have one Chainlink node connected to one oracle contract.

### Job Specifications

The job specifications are the identifiable identifiction numbers associated with a unique Chainlink Oracle. The job specifications should contain the specific information about which blockchain is associated with them.

## Chainlink Request

The Chainlink Request Contract collects oracle and job information from the [bridge contract](#Bridge) to process and submit jobs to a set of Chainlink nodes. The number of oracle jobs (`M`) to be submitted is the minimum number of oracles required for the aggregator contract to receive and to be effectively used to come to a minting consensus.

## Governance