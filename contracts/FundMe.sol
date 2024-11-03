// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


contract FundMe{
    
    mapping(address => uint256) public addressToAmountFunded;
    address[] public founders;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable{
        // 50$
        uint256 min = 50 * 1000000;
        require(getConversionRate(msg.value) >= min,"Not enough!");
        addressToAmountFunded[msg.sender] += msg.value;
        founders.push(msg.sender);
    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000;
        return ethAmountInUsd;
    }



    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }


    function withdraw() payable onlyOwner public{
        payable(msg.sender).transfer(address(this).balance);
        for (uint256 founderIndex =0;  founderIndex < founders.length; founderIndex++){
            address founder = founders[founderIndex];
            addressToAmountFunded[founder] = 0;
        }
        founders = new address[](0);
    }
}