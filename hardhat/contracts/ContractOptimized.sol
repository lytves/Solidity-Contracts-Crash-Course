// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// 15 gwei = 0.00003532 USD

contract ContractOptimized {
    // 1
    uint demo; // uint demo = 0
    // 2
    uint128 a = 1; 
    uint128 b = 1; // "a" and "b" will be packaging to the same memory cell of the 32 bytes (128 + 128 = 256/8 = 32)
    uint256 c = 1;
    // 3
    uint demo2 = 1;  // (256 by default)
    // 4
    bytes32 public hash = 0x9bdfc72eedca5b4c483ffd0d8589266e361ce24c5fd6f207a6aee3e78778d8a3;
    // 5
    mapping(address => uint) payments;
    function pay() external payable {
        require(msg.sender != address(0), "zero address");
        payments[msg.sender] = msg.value;
    }
    // 6
    mapping(address => uint) payments;
    // 9
    uint public result = 1;
    function doWork(uint[] memory data) public {
        uint  temp = 1;
        for (uint i =0; i < data.length; i++) {
            temp *= data[i];
        }
        result = temp; // do not modificate the variable of the state inside the loop, it's better to use a temp variable
    }

            
}
