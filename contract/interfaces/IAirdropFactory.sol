// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IAirdropFactory {
    function lockUpAddr() external view returns (address);

    function randAddr() external view returns (address);

    function wydkAddr() external view returns (address);

    function rewardAddr() external view returns (address);
}
