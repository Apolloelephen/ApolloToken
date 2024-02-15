// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract ApolloToken {
    string public name = "MoneyTrees";
    string public symbol = "MT";
    uint8 public decimal = 18;

    uint256 private tokenTotalSupply;
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowed;

    constructor(uint256 _tokenTotalSupply) {
        tokenTotalSupply = _tokenTotalSupply;
    }

    event Transfer(address indexed sender, address indexed receiver, uint256 amount);

    function totalSupply() public view returns (uint256) {
        return tokenTotalSupply;
    }

    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }

    function approve(address delegate, uint256 numTokens) public  returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
      //   emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public  view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) public  returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] = balances[owner] - numTokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender]-numTokens;
        balances[buyer] = balances[buyer]+ numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}