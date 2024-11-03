// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;


contract SimpleStorage{

    uint256 favNumber;

    struct People{
        uint256 favNumber;
        string name;
    }


    People[] public people;
    mapping(string => uint256) public searchByName;


    function store(uint256 _favNumber) public {
        favNumber = _favNumber;
    }

    function retrieve() public  view returns (uint256){
        return favNumber;
    }

    function addPerson(string memory _name, uint256 _favNumber) public {
        people.push(People({
            favNumber: _favNumber,
            name: _name
        }));
        searchByName[_name] = _favNumber;
    }
    
}