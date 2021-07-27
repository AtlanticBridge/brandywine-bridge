// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;


library BridgeRoles {

    bytes32 public constant OWNER_ROLE = keccak256("OWNER_ROLE");
    bytes32 public constant ORACLE_ROLE = keccak256("ORACLE_ROLE");
    bytes32 public constant PROPSOER_ROLE = keccak256("PROPSOER_ROLE");
    bytes32 public constant VOTER_ROLE = keccak256("VOTER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");  
    bytes32 public constant BRIDGE_ROLE = keccak256("BRIDGE_ROLE");
      
}