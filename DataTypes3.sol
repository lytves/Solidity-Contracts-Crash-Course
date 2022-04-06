// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract DataTypes3 {
    // Enum
    enum Status { Paid, Delivered, Received } // by default is Paid (0 - first index in enum) 
    Status public currentStatus;

    // Array
    uint[10] public uintItems; // = [1,2,3]; // fixed size
    // by default all values are 0 for uint, "" for string, etc. // fixed length
    uint[3][2] public uintItemsTwoDimensional;

    uint[] public uintItemsDynArray; // dynamical size
    uint public uintItemsDynArrayLength;

    // ByteArray
    bytes1 public bytesArray = "3"; // fixed size, store 1 byte
    // can have 1 --> 32 size
    bytes32 public bytesStrArray = "test-bytes-array-size-of-32-byte";
    bytes public bytesDynArray = "Solidity Contract";
    bytes public bytesDynArrayUnicode = unicode"Контракт на Солидити";

    // Struct - customer data structure (customer object)
    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
    }

    struct Balance {
        uint totalPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balances;

    function pay() public {
        currentStatus = Status.Paid;
    }

    function gsetDelivered() public {
        currentStatus = Status.Delivered;
    }

    function addItems() public {
        uintItems[0] = 100;
        uintItems[1] = 200;
        uintItems[3] = 400;
    }

    function addItemsTwoDimensional() public {
        uintItemsTwoDimensional = [
            [3,4,5],
            [6,7,8]
        ];
    }

    function addItemsynamicalArray() public {
        uintItemsDynArray.push(4);
        uintItemsDynArray.push(5);
        uintItemsDynArrayLength = uintItemsDynArray.length;
    }

    function sampleMemoryArray() public view returns(uint[] memory) {
        uint[] memory tempAray = new uint[](10);
        return tempAray;
    }

    function bytesDynArrayLength() public view returns(uint) {
        return bytesDynArray.length;
    }

    function bytesDynArrayUnicodeLength() public view returns(uint) {
        return bytesDynArrayUnicode.length;
    }

    function bytesDynArrayGetChr() public view returns(bytes1) {
        return bytesDynArray[0];
    }

    function pay(string memory payMessage) public payable {
        uint paymentNum = balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++;

        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            payMessage
        );

        balances[msg.sender].payments[paymentNum] = newPayment;
    }

    function getPayment(address _addr, uint _index) public view returns(Payment memory) {
        return balances[_addr].payments[_index];
    }
}