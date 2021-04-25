//SPDX-License-Identifier: Unlicense
pragma solidity >=0.7.0 <=0.9.0;

import {IERC20} from "./erc20Interface.sol";
import "hardhat/console.sol";

contract TargetChitFund {
    struct Member {
        uint targetAmount;
        uint maxMembers;
        uint currentMembers;
    }

    Pool[] public pools;
    mapping (address => uint) poolId;
    mapping (address => uint) userAmount;
    // address TokenAddress = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    // IERC20 dieToken = IERC20(TokenAddress);

    function createPool(address _owner, uint _amount, uint _members) external returns (uint) {
        pools.push(Pool(_amount, _members, 1));
        uint id = pools.length - 1;
        poolId[_owner] = id;
        return id;
    }

    function joinPool(address account, uint _poolId) external returns (bool success) {
        require(pools[_poolId].currentMembers < pools[_poolId].maxMembers);

        poolId[account] = _poolId;
        pools[_poolId].currentMembers += 1;
        success = true;
    }

    function depositAmount(address account, uint amount) external returns (bool) {
        userAmount[account] += amount;
        if (userAmount[account] >= pools[poolId[account]].targetAmount) {
            // Aave call
            return true;
        }

        return true;
    }

    function claimAmount(address account, uint amount) external returns (bool) {
        userAmount[account] = 0;
    }
}