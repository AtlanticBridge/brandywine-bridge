// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AtlanticToken is ERC20 {


    receive() external payable {}

    constructor() public ERC20("Atlantic", "ATL") {
        owner = msg.sender;
        _mint(msg.sender,1000000);          // We want to mint some to the distribution / airdrop contract
        // _mint(ownerContract,1000);       // We want to mint some to the Atlantic Project wallet
    }
}