pragma solidity ^0.8.9;

contract TransactionContract {

    mapping (address => uint) public Balance;

    event AddBalence(address recipient, uint balence, uint totalBalence, bool success);
    event SubBalence(address recipient, uint balence, uint totalBalence, bool success);
    event TransferBalence(address sender,address recipient, uint balence, bool success);

    function initialize() external {

        if(Balance[msg.sender] == 0){
            Balance[msg.sender] = 10;
            emit AddBalence(msg.sender,10,10,true);
        }
        else{
            emit AddBalence(msg.sender,10,10,false);
        }
    }


    function getMyBalence() external view returns (uint bal) {
        bal = Balance[msg.sender];
        return bal;
    }

    function addBalence(uint bal) external{
        Balance[msg.sender] += bal;
        emit AddBalence(msg.sender,bal,Balance[msg.sender],true);
    }

    function subBalence(uint bal) external returns (bool success){

        if(Balance[msg.sender]>=bal){
            Balance[msg.sender] -= bal;
            emit SubBalence(msg.sender, bal, Balance[msg.sender], true);
            return true;
        }
        else{
            emit SubBalence(msg.sender, bal, Balance[msg.sender], false);
            return false;
        }

    }

    function transfer(address recipient, uint bal) external returns (bool success){

        if(Balance[msg.sender]>=bal){
            if(Balance[recipient] == 0){
                Balance[recipient] = 10+bal;
                Balance[msg.sender] -= bal;
                emit TransferBalence(msg.sender, recipient, bal, true);
                return true;
            }
            else{
                Balance[msg.sender] -= bal;
                Balance[recipient] += bal;
                emit TransferBalence(msg.sender, recipient, bal, true);
                return true;
            }
        }
        else{
            emit TransferBalence(msg.sender, recipient, bal, false);
            return false;
        }
    }

}