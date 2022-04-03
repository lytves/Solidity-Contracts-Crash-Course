// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyShop {

    address public owner;
    mapping (address => uint) public payments;

    constructor() {
        owner = msg.sender;
    }

    function payForItem() public payable {
        uint prevValue = payments[msg.sender];
        payments[msg.sender] = prevValue + msg.value;
    }

    function withdrawAll() public {
        // todo, check who is calling the function 
        address payable _to = payable(owner); // temporary variable which we want to mark as "payable"
        address _thisContract = address(this);
        _to.transfer(_thisContract.balance);
    }
}