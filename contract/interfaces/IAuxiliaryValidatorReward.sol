// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAuxiliaryValidatorReward {
    function send(address _owner) external payable;

    function give(address _owner) external returns (uint256);

    function bindParent(address _owner, address _parent) external;
}
