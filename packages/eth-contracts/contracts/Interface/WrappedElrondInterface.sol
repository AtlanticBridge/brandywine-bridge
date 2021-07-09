// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/* The WrappedElrond Interface extends the ERC20 Interface */
interface IWrappedElrond is IERC20 {

    /**
     * @dev The deposit() function takes Eth and mints the equivalent
     * Wrapped Elrond.
     *
     *
     * Requirements
     * ------------
     *
     *      - Must send a minimum amount of 100000 Wei
     */
    function deposit() external payable;

}