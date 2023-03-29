// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";  
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "hardhat/console.sol";

contract InkSwap is ReentrancyGuard  {
    using SafeERC20 for IERC20;
    
    struct Storage{
        bool is18;
        bool plus;
        uint256 dateEnd;
        uint256 amountBase;
    }
    mapping (address => Storage) wallets;   

    mapping(address => uint256) public balances;
    IERC20 public erc20Contract;

    constructor(IERC20 erc20) {
        
        require(address(erc20) != address(0), "ERC20 Incorrecto");
        erc20Contract = erc20;
       
    }
    function addToken(IERC20 token, uint256 amount) public nonReentrant {
        require(token == erc20Contract, "Token Incorrecto");
        require(amount <= token.balanceOf(msg.sender), "No hay fondo suficiente");
        
        token.safeTransferFrom(msg.sender, address(this), amount);
        balances[msg.sender]  += amount;
        
    }

     function sendStorage(bool is18) public payable nonReentrant{
        wallets[msg.sender]= Storage(
            is18,
            balances[msg.sender]  > 0,
            block.timestamp + ((24*60*60) * (is18 ?  40 : 180)),
            msg.value
       );
    }
}