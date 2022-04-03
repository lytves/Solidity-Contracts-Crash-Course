// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract DataTypes {
    // booleans
    bool public myBool; // by default = false
    bool public myOtherBool = true; 
    
    // unsigned integers
    uint public myUint = 42; // by default es uint256  (2 ** 256)
    uint8 public mySmallUint = 2; // 2 ** 8 (values: 0 ===> 256 - 1)
    uint16 public myUint16; // possible uint8, uint16, uint24, uint21 ... uint 256 (max)
 

    // signed integers
    int public myInt = -42;  // by default es int256  (2 ** 256/2 -1  )
    int8 public mySmallInt = -1; // 2 ** 7 (values: -128 ===> 127)

    // demo variables
    uint public minimum;
    uint public maximum;
    uint8 public myVar = 254;

    function myFunc (bool _tmpBool) public {
        bool localBool = false;
        if (localBool && _tmpBool) {
            localBool = true;
        }
    }

    function mathDemo(uint _inputUint) public {
        uint localUint = 41;
        localUint + 1;
        localUint - 1;
        localUint * 2;
        localUint / 2;
        localUint ** 3;
        localUint % 3;
    }

    function getMinimum() public {
        minimum = type(uint8).min;
    }

    function getXaximum() public {
        maximum = type(uint8).max;
    }

    function increment() public {
        myVar++;
    }

    function decrement() public {
        myVar--;
    }

    function incrementUnchecked() public {
        // passed myVar value from 255 (max uint8 value) => 0 (min uint8 value)
        unchecked {
            myVar++;
        }
    }
}