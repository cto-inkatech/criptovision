// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract InkToken is ERC20 {
    constructor( ) ERC20("Ink", "IKT") {
        _mint(msg.sender, 1000000 * (10**decimals()));
    }
}