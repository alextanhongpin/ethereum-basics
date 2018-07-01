pragma solidity ^0.4.23;


contract HelloWorld {
  address owner;
  string greeting = "Hello world";

  constructor() public {
    owner = msg.sender;
  }

  function greet() constant public returns (string) {
    return greeting;
  }

  function kill() public {
    require(owner == msg.sender);
    selfdestruct(owner);
  }
}