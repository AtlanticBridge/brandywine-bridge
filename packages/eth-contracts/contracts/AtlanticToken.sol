// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AtlanticToken is ERC20 {

    address owner;

    receive() external payable {}

    constructor() ERC20("Atlantic", "ATL") public {
        owner = msg.sender;
        _mint(msg.sender,1000000);          // We want to mint some to the distribution / airdrop contract
        // _mint(ownerContract,1000);       // We want to mint some to the Atlantic Project wallet
    }
}