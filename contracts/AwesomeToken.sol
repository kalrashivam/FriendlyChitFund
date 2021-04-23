//SPDX-License-Identifier:  UNLICENSED
pragma solidity >=0.7.0 <=0.9.0;

contract AwesomeToken {
    event Transfer(address indexed _from,
                   address indexed _to,
                   uint256 _value);
    event Approval(address indexed _owner,
                   address indexed _spender,
                   uint256 _value);

    string private _tokenSymbol;
    string private _tokenName;
    uint private _tokenSupply;
    uint128 private _mintCount;
    uint128 private _burnCount;
    uint128 private _transferCount;

    mapping(address => uint) ownerBalance;
    mapping(address => mapping(address => uint)) approvedAmount;

    constructor() {
        _tokenSymbol = 'AWT';
        _tokenName = 'AwesomeTOKEN';
        _tokenSupply = 10000;
    }

    // // Test function: Wouldn't exist in the actual contract
    function addtesttoken(address _to) public returns (bool) {
        ownerBalance[_to] = 5;
        return true;
    }

    function name() public view returns (string memory) {
        return _tokenName;
    }

    function symbol() public view returns (string memory) {
        return _tokenSymbol;
    }

    function totalSupply() public view returns (uint256) {
        return _tokenSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        balance = ownerBalance[_owner];
    }

    function _transfer(address _from, address _to, uint _value) private returns (bool) {
        _beforeTokenTransfer(_from, _to, _value);

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

    function burn(address account, uint256 amount) public returns (bool success) {
        _beforeTokenTransfer(account, address(0), amount);
        uint balance = ownerBalance[account];
        require(balance >= amount);
        ownerBalance[account] -= amount;
        _tokenSupply -= amount;

        emit Transfer(account, address(0), amount);
        success = true;
    }

    function mint(address account, uint256 amount) public returns (bool success) {
        _beforeTokenTransfer(address(0), account, amount);
        require(amount <= _tokenSupply);
        _tokenSupply += amount;
        ownerBalance[account] += amount;

        emit Transfer(address(0), account, amount);
        success = true;
    }

    function _beforeTokenTransfer(address _from, address _to, uint256 amount) private returns (bool) {
        if (_from == address(0)) {
            _mintCount += 1;
        } else if (_to == address(0)) {
            _burnCount += 1;
        } else {
            _transferCount += 1;
        }

        return true;
    }
}
