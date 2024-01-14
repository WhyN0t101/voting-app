// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract VotingSystem {
    address public owner;
    
    // Estrutura para representar um candidato (Bloco)
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Mapeamento para guardar os candidatos
    mapping(uint => Candidate) public candidates;

    // Mapeamento para verificar se o endereço da carteira já votou 
    mapping(address => bool) public voters;

    // Numero de candidatos
    uint public candidatesCount;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this operation");
        _;
    }	
	//Definir o criador do contrato como o proprietário (owner).
    constructor() public {
        owner = msg.sender;
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }


    // Função para adicionarum candidato
    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Função para votar verificando se esta ainda não votou
    function vote(uint _candidateId) public {
        require(!voters[msg.sender], "You have already voted.");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;
    }
    
}
