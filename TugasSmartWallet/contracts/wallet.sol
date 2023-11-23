pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Authorizable.sol";

contract SmartWallet is Authorizable, Ownable {

    using SafeMath for uint256;

    mapping(address => uint256) public tokenBalances;

    constructor(address payable owner) Ownable(owner) {
    }

    function depositToken(address tokenAddress, uint256 amount) public payable {
        ERC20(tokenAddress).transferFrom(msg.sender, address(this), amount);
        tokenBalances[tokenAddress] = tokenBalances[tokenAddress].add(amount);
    }

    function withdrawToken(address tokenAddress, uint256 amount) public {
        require(tokenBalances[tokenAddress] >= amount, "Insufficient balance");
        ERC20(tokenAddress).transfer(msg.sender, amount);
        tokenBalances[tokenAddress] = tokenBalances[tokenAddress].sub(amount);
    }

    function depositETH() public payable {
        address payable sender = msg.sender;
        uint256 amount = sender.balance;
        sender.transfer(0);
        tokenBalances[address(ETH)] = tokenBalances[address(ETH)].add(amount);
    }

    function withdrawETH() public {
        require(tokenBalances[address(ETH)] >= msg.value, "Insufficient balance");
        msg.sender.transfer(msg.value);
        tokenBalances[address(ETH)] = tokenBalances[address(ETH)].sub(msg.value);
    }

    function getBalance(address tokenAddress) public view returns (uint256) {
        return tokenBalances[tokenAddress];
    }
}
