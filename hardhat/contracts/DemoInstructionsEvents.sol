// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract DemoEvents {
    // require
    // revert
    // assert
    address owner;

    // define event, indexed for use an indexed searching
    event Paid(address indexed _from, uint _amount, uint _timestamp);

    constructor() {
        owner = msg.sender;
    }

    // =======================================
    function pay() public payable {
        // emit the event
        emit Paid(msg.sender, msg.value, block.timestamp);
        // this event will be registrated in the blockchain events log
        // we can not read the events log inside the smart contract,
        // but we can subscribed to events from frontend apps
    }

    // require
    function withdraw(address payable _to) external {
        // a condition that should be done in order to continue execute the function
        require(msg.sender == owner, "you are not an owner of the contract!");
        _to.transfer(address(this).balance);
    }

    // revert
    function withdraw2(address payable _to) external {
        // revert abort the execution of the function
        if (msg.sender != owner) {
            revert("you are not an owner of the contract!");
        }
        // else {} - can be used un block "else"
        _to.transfer(address(this).balance);
    }

    // assert
    function withdraw3(address payable _to) external {
        // will throw Panic error if the conditon is not true
        assert(msg.sender == owner);
        _to.transfer(address(this).balance);
    }

    // custom modifier for usage in functions
    modifier onlyOwner() {
        require(msg.sender == owner, "you are not an owner of the contract!");
        _; // continue execute the function where was used modifier
    }

    function withdrawWithModifier(address payable _to) external onlyOwner {
        _to.transfer(address(this).balance);
    }

    // custom modifier for usage in functions
    modifier onlyOwnerAdvanced(address _to) {
        require(msg.sender == owner, "you are not an owner of the contract!");
        require(_to != address(0), "incorrect address"); // address(0) is 0x00000000... address
        _; // continue execute the function where was used modifier
        // require(...); // we can continue run code after parent function executed too
    }

    function withdrawWithModifierAdvanced(address payable _to) external onlyOwnerAdvanced(_to) {
        _to.transfer(address(this).balance);
    }

}