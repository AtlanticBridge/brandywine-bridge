// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// import "./OracleManager.sol";

contract Aggregator {

    /*
    The aggregator contract manages the oracle network. 

        NOTE - Can we dynamically add and remove oracle jobs?
    */
    constructor() public {
        // We want to aggregate the sum of several submissions and figure
        // out which of the values is correct.
    }

    struct myMap {
        mapping(address => bool) _oracles;
    }

    // --- LOCAL VARIABLES ---
    mapping(address => uint256) _oracles;

    // --- GOVERNANCE VARIABLES ---
    uint256 numAggregators;         // Set the number of available aggregators
    uint256 minAggregators;         // Sets the number of required aggregator responses to mint tokens.
    uint256 consensus;              // This sets the minimum number of responses that have to agree on minting metrics for the request to go through.
    // using OracleManager for OracleManager.oracleManager;

}