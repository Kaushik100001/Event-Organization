// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract EventOrganization{
    struct Event{
        address organizer ; 
        string name ; 
        uint date ; 
        uint price ;
        uint TicketCount ;
        uint TicketRemain ; 
    }
    mapping(uint=>Event) public events ;
    mapping (address=>mapping (uint=>uint)) public tickets ; 
    uint public nextId ; 

    function createTicket(string memory name , uint price , uint date , uint TicketCount) external {
              require(date>block.timestamp) ;
              require(TicketCount>0) ;
              events[nextId]=Event(msg.sender , name , date , price , TicketCount , TicketCount) ; 
              nextId ++ ;

    }

    function buyTickets (uint id , uint quantity ) external  payable  {
        require(events[id].date!=0);
        require(events[id].date>block.timestamp);
        Event storage _event = events[id] ; 
        require(msg.value==(_event.price*quantity));
        require(_event.TicketRemain>=quantity);
        _event.TicketRemain-=quantity ;
        tickets[msg.sender][id]+=quantity ; 
        
    }


   
}