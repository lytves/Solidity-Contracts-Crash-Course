// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract DemoFunctions {
    // functions can be:
    // public - can be called from inside, outside
    // external - can be called from outside only
    // internal - can be called from inside only and constracts that inherit this contracts
    // private - can be called from inside only

    // view - function can only read the data from the blockchain
    // pure

    // call (not tx) - fee free
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    // OR other "returns" mode
    function getBalance2() public view returns(uint balance) {
        balance = address(this).balance; // it will returns balance
    }
}