// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;


interface IGodzilla2dStaking {
    // 消费幸运值
    function consume(address _owner, uint256 _total) external;
}
