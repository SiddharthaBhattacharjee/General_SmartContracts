pragma solidity ^0.8.9;

contract ScoreContract {
    mapping (address => uint) public Score;

    event UpdateScore(address user, uint score, bool success);

    function initialize() external {
        if(Score[msg.sender] == 0){
            Score[msg.sender] = 0;
            emit UpdateScore(msg.sender,0,true);
        }
        else{
            emit UpdateScore(msg.sender,0,false);
        }
    }

    function getScore() external view returns (uint score) {
        score = Score[msg.sender];
        return score;
    }

    function updateScore(uint score) external returns (bool success){
        if(Score[msg.sender] < score){
            Score[msg.sender] = score;
            emit UpdateScore(msg.sender, score, true);
            return true;
        }
        else{
            emit UpdateScore(msg.sender, score, false);
            return false;
        }
    }

}

// This smart contract is used to store the high score of the user in a game.
