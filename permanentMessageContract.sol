// A smart contract to do immutable message storage:
// A sender sends a message to a reciever and the there is no way to change the message.
// A user can get sent messages by getSent() and recieved messages by getRecieved().

pragma solidity ^0.8.9;

contract MessageContract {
    struct Message {
        address sender;
        address recipient;
        string message;
        bool isSent;
    }

    mapping (address => Message[]) public Sent;
    mapping (address => Message[]) public Recieved;

    event SendMessage(address sender, address recipient, string message, bool success);
    event RecieveMessage(address sender, address recipient, string message, bool success);

    function initialize() external {
        if(Sent[msg.sender].length == 0){
            Sent[msg.sender].push(Message(msg.sender,msg.sender,"",false));
            emit SendMessage(msg.sender,msg.sender,"",true);
        }
        else{
            emit SendMessage(msg.sender,msg.sender,"",false);
        }
        if(Recieved[msg.sender].length == 0){
            Recieved[msg.sender].push(Message(msg.sender,msg.sender,"",false));
            emit RecieveMessage(msg.sender,msg.sender,"",true);
        }
        else{
            emit RecieveMessage(msg.sender,msg.sender,"",false);
        }
    }

    function getSent() external view returns (Message[] memory sent) {
        sent = Sent[msg.sender];
        return sent;
    }

    function getRecieved() external view returns (Message[] memory recieved) {
        recieved = Recieved[msg.sender];
        return recieved;
    }

    function sendMessage(address recipient, string memory message) external returns (bool success){
        Sent[msg.sender].push(Message(msg.sender,recipient,message,true));
        Recieved[recipient].push(Message(msg.sender,recipient,message,false));
        emit SendMessage(msg.sender, recipient, message, true);
        return true;
    }

    function recieveMessage(uint index) external returns (bool success){
        if(Recieved[msg.sender][index].isSent == false){
            Recieved[msg.sender][index].isSent = true;
            emit RecieveMessage(Recieved[msg.sender][index].sender, Recieved[msg.sender][index].recipient, Recieved[msg.sender][index].message, true);
            return true;
        }
        else{
            emit RecieveMessage(Recieved[msg.sender][index].sender, Recieved[msg.sender][index].recipient, Recieved[msg.sender][index].message, false);
            return false;
        }
    }

}