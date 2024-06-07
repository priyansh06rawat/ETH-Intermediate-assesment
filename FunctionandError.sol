// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract FunctionAndError {
    uint public x;
    bool public isEven;

    function set(uint _x) public {
        require(_x != x, "New value must be different from current value");
        x = _x;
        isEven = (_x % 2 == 0);
    }

    function double() public {
        require(x != 0, "Cannot double zero");
        x *= 2;
        isEven = true; 
    }

    function resetX() public {
        require(x != 0, "x is already 0");
        x = 0;
        isEven = false; 
    }
}
