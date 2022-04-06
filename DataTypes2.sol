// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract DataTypes2 {
    // string
    string public myStr = "test string"; // storage-blockchain
    // address
    address public myAddr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    // mapping
    mapping (address => uint) public payments;

    function tmpStr() public {
        string memory myTmpStr = "temp test string"; // memory
        myStr = "new test string value";
    }

    function tmpStrMemory(string memory newValueStr) public {
        myStr = newValueStr;
    }

    function getMyBalance() public view returns(uint) {
        return myAddr.balance;
    }

    function getAddressBalance(address targetAddress) public view returns(uint) {
        return targetAddress.balance;
    }

    function transferTo(address targetAddress, uint amount) public {
        address payable _to = payable(targetAddress);
        _to.transfer(amount); // transfer from this account contract
    }

    function receiveFounds() public payable {
        payments[msg.sender] = msg.value;
    }
}