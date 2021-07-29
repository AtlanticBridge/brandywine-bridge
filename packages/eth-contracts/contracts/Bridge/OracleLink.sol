// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;


contract OracleLink {
    address[] public oracleList;

    mapping(address => bytes32) jobIdList;

    struct Transaction {
        uint256 txId;
        address _to;
        uint256 amount;
        uint256 prctCost;
    }


    function addOracle(
        address _oracle
    ) public {
        // Add any modifiers here
        oracleList.push(_oracle);
    }

    function addJob(
        address _oracle,
        string memory _jobId
    ) public {
        // Require that the Oracle already exists.
        jobIdList[_oracle] = _jobId;
    }
}