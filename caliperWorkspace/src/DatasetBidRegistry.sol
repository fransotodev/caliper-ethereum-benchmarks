pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";


/** @title A registry of dataset bids. */
contract DatasetBidRegistry is Ownable {
   
   struct Bid{
       string expiry_date; // Standard human readable date, e.g. Wed Jan 25 2017 16:00:00 GMT-0800
       string hash_spec;   // Specs of the dataset
       uint amount;        // amount in wei for the bid.
       string tag;	//keyword
   }
   struct Offer{
      address offerer;  // Must be a smart contract. 
      address bidder;
      uint bid_number;
      uint value;
      bool completed;
   }
   event BidRegistered(
          address who,
          uint position   // Notification for interested parties.
    );
    event OfferRegistered(
          address to,
          address from,
          uint bid_number,   // Notification for interested parties.
          uint offer_number
    );
   mapping (address => Bid[]) public bids;
   mapping (address => mapping (uint => Offer[])) public offers;


  /** @dev Register a temporary dataset bid.
    * @param date Expiration date of the bid.
    * @param hash_spec Hash to the spec of the bid.
    * @param amount Amount to be paid for the dataset.
     */
  function register(string memory date,
                    string memory hash_spec,
                    uint amount,
                    string memory tag) public {
      bids[msg.sender].push(Bid(date, hash_spec, amount, tag));
      emit BidRegistered(msg.sender, bids[msg.sender].length-1);
  }

  /**
   */
   function offer(address recp, uint bidno, uint price) public {
         offers[recp][bidno].push(Offer(recp, msg.sender, bidno, price, false));
         emit OfferRegistered(recp, msg.sender, bidno, offers[recp][bidno].length - 1);
   }

   /**
    *
    */
   function finalize(address recp, uint bidno, uint offerno) public payable{
        assert(msg.sender == offers[recp][bidno][offerno].bidder);
        assert(msg.value == offers[recp][bidno][offerno].value);
        offers[recp][bidno][offerno].completed = true;
        // Call the contract in charge of the distribution of funds and transfer the value.
   } 

}