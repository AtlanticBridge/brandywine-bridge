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
    // 100 oracles => 20 requests. >20 Oracles, then select only 20. Chainlink VRF
    address private _bridgeContract;
    uint256 private _numOracles;                                // Index starts at 0, but numNodes is the TOTAL amount of nodes in the list. When indexing, use [ _numNodes - 1 ].
    mapping(address => bool) private authorizedOracles;         // The authorized nodes allow us to ping multiple nodes and aggregate responses through the same Oracle contract.
    mapping(address => bytes32[]) private jobIds;               // Holds the specific jobIds for that Oracle.
    mapping(bytes32 => BridgeJobInfo) private bridgeJobInfo;    // Holds the jobId information.

    // We want to:
    //  1. RATE LIMIT
    //  2. MAXIMUM USAGE.
    //      - Oracle Contracts are tied to Node operators. We want to limit the
    //        maximum usage of each of these in order to maintain security measures
    //        and as an extra layer of security for any external adapters that are
    //        might trying to hack or distrub the network.
    //  3. CIRCUIT BREAKER.
    //      - If something goes wrong in the smart contract, we want to be able to 
    //        pause the contract.

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

        _numOracles    += 1;
        fee             = init_fee;                                                     // (Varies by network and job)
        _bridgeContract = 0xFA9E7d769870CEAa202C1090D80daF7CBd655F56;       // This address should be the address of the bridge contract (There might be a circular loop here as the Bridge Contract will need the address of this contract.)
        _oracleList.push(0xFA9E7d769870CEAa202C1090D80daF7CBd655F56);       // Set the initial Node address.

        // Setup the initial list of Job Specifications.
        jobId_eth2erd = "ENTER_NUMBER_HERE";                                // Add the jobID of your chainlink external adapter job here.

    }


    /**
     * @notice Adds a new approved Chainlink node to the Oracle contract
     */
    function _addOracle() internal pure {
        
    }

    /**
     * @notice Adds a new approved Chainlink node to the Oracle contract
     */
    function getNumOracles() public view returns (uint256) {
        return _numOracles;
    }


    /**
     *
     */
    function getOracles() public view returns (address) {

        // We want only the Bridge2Elrond.sol contract to 



        for (uint i = 0; i < _numOracles; i += 1) {
            address temp_oracle = _oracleList[i];
            bytes32[] storage _jobIds = jobIds[_oracle];
            bytes32 _jobId = _getSpecificJob(_jobIds, "elrond");  // We want to call the correct Bridge.
        }
    }

    function getJobIds(address _oracle) public view returns (string memory) {

    }




    // ***********************
    // --- PRIVATE METHODS ---
    // ***********************


    /**
     * _getSpecificJob()
     *
     *           Receives the fulfillElrondTransfer() response in the form of bytes32.
     *            
     * 
     * Parameters
     * ----------
     * _jobIds : bytes32[]
     *            - The list of available bridges to transfer funds to.
     *
     * bridgeName : string
     *            - The name of the bridge a user wants to transfer to.
     *
     *
     *
     */
    function _getSpecificJob(
        bytes32[] storage _jobIds,
        string memory bridgeName
    ) private view returns (bytes32) {

        // TODO: Check if _jobIds is empty / add modifier.
        // TODO: Add a failed return statement.


        for (uint i = 0; i < _jobIds.length; i+= 1) {
            BridgeJobInfo memory jobInfo = bridgeJobInfo[_jobIds[i]];
            
            if (Math.CompareStrings(jobInfo.name, bridgeName)) {
                return (jobInfo.jobId);
            }
        }
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

    modifier onlyBridge {
        require(hasRole(BridgeRoles.BRIDGE_ROLE, _bridgeContract));
        _;
    }
}