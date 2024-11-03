// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./SimpleStorage.sol";

contract StorageFactory is SimpleStorage{

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simplestorage = new SimpleStorage();
        simpleStorageArray.push(simplestorage);
    }


    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public{
        // Address
        //Abi
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);
    }


    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
    }
}