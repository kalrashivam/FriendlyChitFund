//SPDX-License-Identifier: Unlicense
pragma solidity >=0.7.0 <=0.9.0;

import {IERC20} from "./erc20Interface.sol";
import "hardhat/console.sol";

contract TargetChitFund {
    struct Pool {
        uint targetAmount;
        uint maxMembers;
    }

    Pool[] public pools;
    mapping(address => uint) poolId;
    mapping(address => uint) userAmount;
    // address TokenAddress = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    // IERC20 dieToken = IERC20(TokenAddress);

    function _deposit(address _account, uint _amount) private returns (bool) {
        userAmount[_account] += _amount;
        // Move token from address to aave
        return true;
    }

    function _withdraw(address _account) private returns (bool) {
        // Move token from aave to address
        delete poolId[_account];
        userAmount[_account] = 0;
        return true;
    }

    function createPool(address _owner, uint _amount, uint _members) public returns (bool) {
        pools.push(Pool(_amount, _members));
        poolId[_owner] = pools.length - 1;
        return true;
    }

    function joinPool(address _account, uint _poolId) external returns (bool) {
        require(pools.length - 1 <= _poolId, "Pool does not exist");
        poolId[_account] = _poolId;
        return true;
    }

    function depositAmount(address _account, uint _amount) external returns (bool) {
        require(poolId[_account] >= 0, "Account not part of a pool.");

        if ((userAmount[_account] + _amount) >= pools[poolId[_account]].targetAmount) {
            _withdraw(_account);
        } else {
            _deposit(_account, _amount);
        }

        return true;
    }
}