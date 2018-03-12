pragma solidity ^0.4.8;

contract Notaire{
    //VARIABLES
    address public owner;
    string public hash;

function Notaire(address _owner,string _hash) public {
        owner=_owner;
        hash=_hash;
} 
   

    //MODIFIER & EVENTS

   modifier isowner(){
       if(msg.sender!=owner){
           throw;
       }
       _;
    }
    
    
    //KILL

    function kil() isowner(){
        delete owner;
        selfdestruct(msg.sender);
    }
    
    
}