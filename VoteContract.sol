pragma solidity ^0.8.9;

contract VoteContract{

    uint idea_count = 0;

    struct idea{
        uint index;
        string desc;
        uint vote;
    }

    mapping(address=>uint) Balance;
    mapping(uint=>idea) Ballet; // here first uint represent the index number of idea and second is the uint of votes in favour of idea

    event AddBalence(address recipient, uint amount);
    event SubBalenceSuccess(address recipient,uint amount);
    event SubBalenceFailure(address recipient,uint amount);
    event TransferBalenceSuccess(address sender, address recipient, uint amount);
    event TransferBalenceFailure(address sender, address recipient, uint amount);
    event AddedIdea(address sender,uint pos);
    event voted(address sender,uint index,uint votes);
    event voteFailed(address sender,uint index,uint votes);

    function addIdea(string calldata ideadesc) external{
        Ballet[idea_count] = idea(idea_count,ideadesc,0);
        idea_count+=1;
        emit AddedIdea(msg.sender,idea_count-1);
    }

    function addBalence(uint bal) external{
        Balance[msg.sender] += bal;
        emit AddBalence(msg.sender,bal);
    }

    function subBalence(uint bal) external returns (bool success){

        if(Balance[msg.sender]>=bal){
            Balance[msg.sender] -= bal;
            emit SubBalenceSuccess(msg.sender, bal);
            return true;
        }
        else{
            emit SubBalenceFailure(msg.sender, bal);
            return false;
        }

    }

    function transfer(address recipient, uint bal) external returns (bool success){

        if(Balance[msg.sender]>=bal){
            Balance[msg.sender] -= bal;
            Balance[recipient] += bal;
            emit TransferBalenceSuccess(msg.sender, recipient, bal);
            return true;
        }
        else{
            emit TransferBalenceFailure(msg.sender, recipient, bal);
            return false;
        }
    }

    function vote(uint ideaIndex, uint bal) external returns (bool success){

        if(Balance[msg.sender]>=bal){
            Balance[msg.sender] -= bal;
            Ballet[ideaIndex].vote += bal;
            emit voted(msg.sender,ideaIndex,bal);
            return true;
        }
        else{
            emit voteFailed(msg.sender,ideaIndex,bal);
            return false;
        }
    }

    function getMyBalence() external view returns (uint bal) {
        return Balance[msg.sender];
    }

    function getIdea(uint ideaindex) external view returns (idea memory i) {
        return Ballet[ideaindex];
    }

    function getBalence(address target) external view returns (uint bal) {
        return Balance[target];
    }
    

}