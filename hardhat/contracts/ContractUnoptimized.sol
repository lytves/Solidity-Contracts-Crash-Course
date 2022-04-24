// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ContractUnoptimized {
    // 1
    uint demo = 0;
    // 2
    uint128 a = 1; 
    uint256 c = 1;
    uint128 b = 1; // "a","b", "c" will be packaging to diferents memory sells
    // 3
    uint8 demo2 = 1; // casting variables has cost, sometimes is better to use without casting of types (256 by default)
    // 4
    bytes32 public hash = keccak256(
        abi.encodePacked("test")
    );
    // 5
    mapping(address => uint) payments;
    function pay() external payable {
        address _from = msg.sender;
        require(_from != address(0), "zero address");
        payments[_from] = msg.value;
    }
    // 6
    uint[] payments2; // arrays is quite more expensive than mappings
    uint[10] payments3; // array with defined size is better than with dynamically size
    // 7
    // do not create a lot of function with destructuring funcionality
    // 8
    // do not create a big strings, more than 32 bytes
    // 9 
    uint public result = 1;
    function doWork(uint[] memory data) public {
        for (uint i =0; i < data.length; i++) {
            result *= data[i];
        }
    }
}
