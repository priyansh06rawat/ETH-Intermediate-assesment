// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract Bank {
    mapping(address => uint) public balances;
    bool public isOperational;

    // Constructor to initialize the contract with the bank being non-operational
    constructor() {
        isOperational = false; // Bank starts as non-operational
    }

    function deposit() public payable {
        require(isOperational, "Bank is not operational");
        require(msg.value > 0, "Deposit amount must be greater than zero");

        balances[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require(isOperational, "Bank is not operational");
        require(amount <= balances[msg.sender], "Insufficient balance");

        balances[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }

    function doubleBalance() public {
        assert(balances[msg.sender] > 0);
        
        balances[msg.sender] *= 2;
    }

    function resetBalance() public {
        if (balances[msg.sender] == 0) {
            revert("Balance is already zero");
        }

        balances[msg.sender] = 0;
    }

    function toggleOperational() public {
        isOperational = !isOperational;
    }
}
