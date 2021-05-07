// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "../../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  //add minter variable
  address public minter;

  //add minter changed event
  event MinterChanged(address indexed from, address to);

  constructor() payable ERC20("Decentralized Bank Currency", "DBC") {
    //assign initial minter to the account that deploys the contract
    // msg is a global variable in solidity and sender is the person that deployed the 
    // contract
    minter = msg.sender;
  }

  //Add pass minter role function
  function passMinterRole(address dBank) public returns(bool) {
    // require the msg.sender to be the minter, otherwise stop function execution
    require(msg.sender == minter, "Error, only the owner can pass along the minter role");
    // set the state variable minter to the dBank argument 
    minter = dBank;
    // emit an event that the minter has changed
    emit MinterChanged(msg.sender, dBank);
    // return true to indicate the pass over was successful
    return true;
  }

  function mint(address account, uint256 amount) public {
    //check if msg.sender have minter role
    require(msg.sender == minter, "Cannot Mint, MSG.Sender does not have minter role");
		_mint(account, amount);
	}
} 