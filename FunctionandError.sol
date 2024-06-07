//write a smart contract that implements the require(), assert() and revert() statements.
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
        assert(x>0);
        x *= 2;
        isEven = true; 
    }

    function resetX() public {
        if (x == 0) {
            revert("x is already 0");
        }
        x = 0;
        isEven = false; 
    }
}
