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

    mapping(address => uint) ownerBalance;
    mapping(address => mapping(address => uint)) approvedAmount;

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

    function _transfer(address _from, address _to, uint _value) private returns (bool) {
        ownerBalance[_from] -= _value;
        ownerBalance[_to] = _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(ownerBalance[msg.sender] >= _value);
        success = _transfer(msg.sender, _to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(approvedAmount[_from][_to] >= _value);
        approvedAmount[_from][_to] -= _value;
        success = _transfer(_from, _to, _value);
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        remaining = approvedAmount[_owner][_spender];
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        approvedAmount[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        success = true;
    }
}