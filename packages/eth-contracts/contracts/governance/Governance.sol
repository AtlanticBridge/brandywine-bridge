// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/upgrades-core/contracts/Initializable.sol";
import "../Utils/Math.sol";
import "./Roles.sol";

contract Governance is AccessControl {

    using BridgeRoles for bytes32;

    bytes32 private jobId_eth2erd;
    bool private initialized;
    uint256 private fee;
    address private _oracle;
    address[] private _oracleList;
    uint256 private _numOracles;                                // Index starts at 0, but numNodes is the TOTAL amount of nodes in the list. When indexing, use [ _numNodes - 1 ].
    mapping(address => bool) private authorizedOracles;         // The authorized nodes allow us to ping multiple nodes and aggregate responses through the same Oracle contract.
    mapping(address => bytes32[]) private jobIds;               // Holds the specific jobIds for that Oracle.
    mapping(bytes32 => BridgeJobInfo) private bridgeJobInfo;    // Holds the jobId information.

    // --- STRUCTS ---
    struct BridgeJobInfo {
        string name;
        uint256 chainId;
        bytes32 jobId;
    }


    // --- Governance Metrics ---
    /**
     * The governance contract metrics are the variables that can change 
     * within the governance ecosystem. 
     */

    /**
     * Network: Kovan
     * Oracle: 0xFA9E7d769870CEAa202C1090D80daF7CBd655F56
     * Job ID Average: 58ae9ae2e43a45219185bec59b3794eb
     * Job ID Highlow: 740306a4d92d4ab1ad07f033183a5975
     * Fee: 1.1 LINK
     */
    function initialize(uint256 init_fee) public {

        require(!initialized, "Contract instance has already been initialized");
        initialized = true;

        _oracleList.push(0xFA9E7d769870CEAa202C1090D80daF7CBd655F56);     // Set the initial Node address.
        _numOracles += 1;
        // _oracle = 0xFA9E7d769870CEAa202C1090D80daF7CBd655F56;
        // oracle = 0xFA9E7d769870CEAa202C1090D80daF7CBd655F56;        // Add your node oracle here.

        // Setup the initial list of Job Specifications.
        jobId_eth2erd = "ENTER_NUMBER_HERE";                        // Add the jobID of your chainlink external adapter job here.
        fee = init_fee;                                                 // (Varies by network and job)

    }


    /**
     * @notice Adds a new approved Chainlink node to the Oracle contract
     */
    function _addOracle() internal pure {
        
    }

    // *****************
    // --- MODIFIERS ---
    // *****************
    modifier minimumAmount {
        require(msg.value > 100000);
        _;
    }

    modifier onlyOwner {
        require(hasRole(BridgeRoles.OWNER_ROLE, msg.sender));
        _;
    }

    modifier onlyOracle {
        require(hasRole(BridgeRoles.ORACLE_ROLE, msg.sender));
        _;
    }

     modifier onlyProposer {
        require(hasRole(BridgeRoles.PROPSOER_ROLE, msg.sender));
        _;
    }

    modifier onlyVoter {
        require(hasRole(BridgeRoles.VOTER_ROLE, msg.sender));
        _;
    }

    modifier onlyMinter {
        require(hasRole(BridgeRoles.MINTER_ROLE, msg.sender));
        _;
    }
}