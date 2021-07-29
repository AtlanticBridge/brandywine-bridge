// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;


/**
 * @title Handles the Oracle Information and Access
 * 
 * @dev 
 */
contract OracleManager {

    struct Oracle {
        uint id;
        uint256 fee;
        bytes32 jobId;
        address oracle;
    }

    uint256 numOracles;

    mapping(uint256 => Oracle) OracleList;

`
    /**
        @dev This function interfaces with the governance contract to add a new oracle solution 
     */
    function addOracle() public { }
}