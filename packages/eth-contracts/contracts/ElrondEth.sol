// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";

contract ElrondEth is ERC20, ERC20Burnable {

    // NOTE: Rename to DittoEther with Symbol dEth

    address owner;                      // The owner of the contact upon deployment.
    uint256 fee = 0.005 * 10**18;       // Fee in Wei ( 0.005 ETH ) to account for gas prices upon withdrawl.

    // EVENTS
    event Mint(address indexed to, uint256 amount);


    receive() external payable {}

    constructor() ERC20("ElrondEth", "eETH") {
        owner = msg.sender;
    }


    /**
     * @dev Mints the equivalent tokens as the amount of ETH sent.
     *
     *
     * Requirements:
     *
     *   - Must send a minimum amount of 100000 Wei
     *
     */
    function deposit() minimumAmount external payable {
        // Mint the amount sent.
        _mint(msg.sender, msg.value);
        // Emit the minting action.
        emit Mint(msg.sender, msg.value);
    }


    /**
     * @dev User wants to withdraw funds back to ETH
     * from MyEth coin.
     *
     *
     * Requirements:
     *
     *   - The sender cannot be the owner address
     *   - The amount requested cannot be greater than 
     *       the amount available in the smart contract.
     *   - The sender cannot send more tokens that they have.
     */
    function withdraw(uint256 amount) external {

        uint256 dexBalance    = balanceOf(address(this));
        uint256 senderBalance = balanceOf(msg.sender);
        
        // --- WHAT IS REQUIRED ---
        require(msg.sender != address(0), "Cannot transfer from the zero address");
        require(amount <= dexBalance, "Cannot request more than the available ETH balance");
        require(amount <= senderBalance, "Cannot send more than you have");

        // Transfers the amount of tokens from the sender to the owner
        transfer(owner, amount);

        // Check to see if the user sent 
        address(this).transfer(10000);

        // Burn the tokens 
        burnFrom(address(this), amount);
    }


    // --- MODIFIERS ---
    modifier minimumAmount {
        require(msg.value > 100000);
        _;
    }
}