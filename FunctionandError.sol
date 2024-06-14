// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract DecentralizedVoting {

    struct Option {
        string name;
        uint voteCount;
    }

    struct Voter {
        bool hasVoted;
        uint votedOptionId;
    }

    address public owner;
    bool public votingActive;
    Option[] public options;
    mapping(address => Voter) public voters;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier votingEnabled() {
        require(votingActive, "Voting is not active");
        _;
    }

    constructor() {
        owner = msg.sender;
        votingActive = false;
    }

    function addOption(string memory name) public onlyOwner {
        options.push(Option({name: name, voteCount: 0}));
    }

    function startVoting() public onlyOwner {
        require(options.length > 1, "Need at least two options to start voting");
        votingActive = true;
    }

    function stopVoting() public onlyOwner {
        votingActive = false;
    }

    function vote(uint optionId) public votingEnabled {
        Voter storage sender = voters[msg.sender];
        require(!sender.hasVoted, "You have already voted");
        require(optionId < options.length, "Invalid option ID");

        sender.hasVoted = true;
        sender.votedOptionId = optionId;

        options[optionId].voteCount += 1;

        // Assert to check internal consistency
        assert(options[optionId].voteCount > 0);
    }

    function getOption(uint optionId) public view returns (string memory name, uint voteCount) {
        require(optionId < options.length, "Invalid option ID");

        Option storage option = options[optionId];
        return (option.name, option.voteCount);
    }

    function getOptionsCount() public view returns (uint) {
        return options.length;
    }

    function getWinner() public view returns (string memory winnerName, uint winnerVoteCount) {
        require(!votingActive, "Voting is still active");

        uint winningVoteCount = 0;
        uint winningOptionId = 0;
        
        for (uint i = 0; i < options.length; i++) {
            if (options[i].voteCount > winningVoteCount) {
                winningVoteCount = options[i].voteCount;
                winningOptionId = i;
            }
        }

        // Assert to check that there is at least one option
        assert(options.length > 0);

        winnerName = options[winningOptionId].name;
        winnerVoteCount = options[winningOptionId].voteCount;
    }

    function resetVoting() public onlyOwner {
        // Use revert to handle a specific error condition
        if (votingActive) {
            revert("Cannot reset while voting is active");
        }

        for (uint i = 0; i < options.length; i++) {
            options[i].voteCount = 0;
        }

        for (uint i = 0; i < options.length; i++) {
            // Assert to ensure all vote counts are reset
            assert(options[i].voteCount == 0);
        }
    }
}
