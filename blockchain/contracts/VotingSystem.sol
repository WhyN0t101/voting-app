// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract VotingSystem {
    address public owner;
    
    // Structure to represent a candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Mapping to store the candidates
    mapping(uint => Candidate) public candidates;

    // Mapping to check if an address has already voted
    mapping(address => bool) public voters;

    // Number of candidates
    uint public candidatesCount;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this operation");
        _;
    }

    constructor() public {
        owner = msg.sender;
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }


    // Function to add a new candidate
    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Function to cast a vote
    function vote(uint _candidateId) public {
        require(!voters[msg.sender], "You have already voted.");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;
    }
    
}
