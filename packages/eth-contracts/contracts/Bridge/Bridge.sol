// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/upgrades-core/contracts/Initializable.sol";
import "../Utils/Math.sol";
import "../Governance/Roles.sol";

contract Bridge is AccessControl {

    // Instantiable Variables
    using BridgeRoles for bytes32;
    bool private initialized;

    address[] private _oracleList;                  // List of oracles.
    mapping(address => bytes32[]) private jobIds;   // Holds the specific jobIds for that Oracle.
    
    mapping(bytes32 => BridgeJobInfo) BridgeQueue;  // A way to keep track of working jobs

    // --- STRUCTS ---
    struct BridgeJobInfo {
        string name;
        uint256 chainId;
        bytes32 jobId;
    }

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



    /**
     * initialize()
     *
     *
     * DESCRIPTION
     * -----------
     * The initialization function when deploying new updates to the contract.
     *
     *
     * PARAMETERS
     * ----------
     * _oracle : address
     *      - Chainlink Oracle Contract to add to the oracle list.
     *
     * _governorRole : address
     *      - The Governance Contract for setting the Governor Role.
     *
     * _jobid : bytes32
     *      - The job identification for the initial oracle contract.
     */
    function initialize(
        address _oracle,
        address _governorRole,
        bytes32 _jobid
    ) public {

        require(!initialized, "Contract instance has already been initialized");
        initialized = true;

        _oracleList.push(_oracle);          // Set the initial Node address.
        jobIds[_oracle].push(_jobid);

        // --- SET INITIAL PERMISSIONS ROLE ---
        _setupRole(BridgeRoles.OWNER_ROLE, msg.sender);
        _setupRole(BridgeRoles.GOVERNOR_ROLE, _governorRole);
        _setupRole(BridgeRoles.OWNER_ROLE, _oracle);

    }


    /**
     * getNumOracles()
     *
     *
     * DESCRIPTION
     * -----------
     * Returns the number of Oracles in the bridge.
     *
     *
     * PARAMETERS
     * ----------
     * none
     */
    function getNumOracles() public view returns (uint256) {
        return _oracleList.length;
    }


    /**
     * getNumOracles()
     *
     *
     * DESCRIPTION
     * -----------
     * Returns the list of Oracle addresses in the bridge.
     *
     *
     * PARAMETERS
     * ----------
     * none
     */
    function getOracles()
      public view
      returns (address[] memory)
    {
        return _oracleList;
    }


    /**
     * setChainLinkRequestContract()
     *
     *
     * DESCRIPTION
     * -----------
     * Sets the CHAINLINK_REQUEST_ROLE to the ChainlinkRequest Contract.
     *
     *
     * PARAMETERS
     * ----------
     * _chainlinkRequest : address
     *      - The address of the ChainlinkRequest.sol deployed contract.
     *
     */
    function setChainLinkRequestContract(
        address _chainlinkRequest
    ) public 
      onlyOwner
    {
        _setupRole(BridgeRoles.CHAINLINK_REQUEST_ROLE, _chainlinkRequest);
    }

    /**
     * _addOracle()
     *
     *
     * DESCRIPTION
     * -----------
     * Adds a new approved Chainlink node to the Oracle contract
     *
     *
     * PARAMETERS
     * ----------
     * _oracle : address
     *      -  Chainlink Oracle Contract to add to the oracle list.
     */
    function _addOracle(
        address _oracle
    ) public
      onlyGovernor
    {
        _oracleList.push(_oracle);
    }


    // ***********************
    // --- PRIVATE METHODS ---
    // ***********************

    /**
     * _getSpecificJob()
     *
     *
     * DESCRIPTION
     * -----------
     * Receives the fulfillElrondTransfer() response in the form of bytes32.
     *            
     * 
     * PARAMETERS
     * ----------
     * _jobIds : bytes32[]
     *      - The list of available bridges to transfer funds to.
     *
     * bridgeName : string
     *      - The name of the bridge a user wants to transfer to.
     *
     */
    function getJobIds(
        address _oracle
    ) onlyChainlinkRequest onlyOwner
      public view
      returns (bytes32[] memory)
    {
        return jobIds[_oracle];
    }

    // *****************
    // --- MODIFIERS ---
    // *****************
    modifier minimumAmount {
        require(msg.value > 100000);
        _;
    }

    modifier onlyGovernor {
        require(hasRole(BridgeRoles.GOVERNOR_ROLE, msg.sender),"Must be the GOVERNOR CONTRACT to call.");
        _;
    }

    modifier onlyOwner {
        require(hasRole(BridgeRoles.OWNER_ROLE, msg.sender), "Must be the OWNER to call.");
        _;
    }

    modifier onlyChainlinkRequest() {
        require(hasRole(BridgeRoles.CHAINLINK_REQUEST_ROLE, msg.sender), "Must be the CHAINLINK REQUEST CONTRACT to call.");
        _;
    }

    modifier onlyOracle {
        require(hasRole(BridgeRoles.ORACLE_ROLE, msg.sender), "Must be the ORACLE CONTRACT to call.");
        _;
    }

    modifier onlyProposer {
        require(hasRole(BridgeRoles.PROPSOER_ROLE, msg.sender), "Must be a PROPOSER to call.");
        _;
    }

    modifier onlyVoter {
        require(hasRole(BridgeRoles.VOTER_ROLE, msg.sender), "Must be a VOTER to call.");
        _;
    }

    modifier onlyMinter {
        require(hasRole(BridgeRoles.MINTER_ROLE, msg.sender), "Must be the MINTER to call.");
        _;
    }

    modifier onlyBridge {
        require(hasRole(BridgeRoles.BRIDGE_ROLE, msg.sender), "Must be the BRDIGE CONTRACT to call.");
        _;
    }
}