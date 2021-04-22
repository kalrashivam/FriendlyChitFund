//SPDX-License-Identifier: <SPDX-License>
pragma solidity >=0.7.0 <=0.9.0;

contract AwesomeToken {
    event Transfer(address indexed _from,
                   address indexed _to,
                   uint256 _value);
    event Approval(address indexed _owner,
                   address indexed _spender,
                   uint256 _value);

    string tokenSymbol = 'AWT';
    string tokenName = 'AwesomeTOKEN';
    uint tokenSupply = 10000;

    mapping (address => uint) ownerBalance;

    function name() public view returns (string memory) {
        return tokenName;
    }

    function symbol() public view returns (string memory) {
        return tokenSymbol;
    }

    function totalSupply() public view returns (uint256) {
        return tokenSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        balance = ownerBalance[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(ownerBalance[msg.sender] >= _value);
        ownerBalance[msg.sender] -= _value;
        ownerBalance[_to] = _value;
        emit Transfer(msg.sender, _to, _value);
        success = True;
    }
}