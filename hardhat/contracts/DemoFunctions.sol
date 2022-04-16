// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract DemoFunctions {
    // functions can be:
    // public - can be called from inside, outside
    // external - can be called from outside only
    // internal - can be called from inside only and constracts that inherit this contracts
    // private - can be called from inside only

    // view - function only read the data from the blockchain
    // pure - function only read the data from the blockchain and can not access to contract states data (contract's variables)

    string message = "hello";
    uint public balance;

    // ============================================================
    // call (not tx) - fee free
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    // OR other "returns" mode
    function getBalance2() public view returns(uint balance) {
        balance = address(this).balance; // it will returns balance
    }

    // usage of "pure" here is an error
    function getMessage() external view returns(string memory) {
        return message;
    }

    // usage of pure
    function getMessage2(uint amount) external pure returns(uint) {
        return amount * 3;
    }

    // transaction (tx) - is a function that modifies the blockchain data. And can not return data
    function setMessage(string memory newMessage) public {
        message = newMessage;
    }

    // payable function - can receive eth, tokens
    function pay() external payable {
        // not is necesary to manage this, payable amount will be added to contract's balance automatically
        // balance += msg.value;
    }

    // function that will receive amount from tx to current contract without call some function, when amount was sent directly to contract address
    receive() external payable {
        // balance += msg.value;
    }

    // function that will called then was called some contract function that not exists
    fallback() external payable {

    }

}