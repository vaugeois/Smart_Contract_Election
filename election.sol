pragma solidity ^0.4.8;

contract Election{
    //VARIABLES
    address public owner;

    uint public death_block;
    
    mapping(address=>uint) public elector;    
    mapping(address=>uint) public candidate;
   

    //MODIFIER & EVENTS

   modifier isowner(){
       if(msg.sender!=owner){
           throw;
       }
       _;
    }
    
     modifier didNotVoteYet(address index) {
        if(elector[index]!=1) {throw;
        }
        _;
    }
    
    modifier isover(){
        if(block.number>death_block){
            throw;
        }
        _;
    }
    

   
   //CONSTRUCTOR
   
   function  Add_Candidate(address candida) public isowner(){
       candidate[candida]=0;
   }
   
   function Set_Death(uint death) public isowner(){
       death_block=death;
   }
   
    function Add_Elector(address elec) public isowner(){
        elector[elec]=1;
   }
   
   function vote(address index_elec,address index_cand) public didNotVoteYet(index_cand) isover() {
        elector[index_elec]--;
        candidate[index_cand]++;
    }
   
   function Election(uint death) public{
        owner=msg.sender;
        death_block=death;
   }
    
    //KILL

    function kil() isowner(){
        delete owner;
        delete death_block;
        selfdestruct(msg.sender);
    }
    
    
}