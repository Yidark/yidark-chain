// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC721MiningFactory {
    function start(
        address _tokenAddr,
        uint256 _dayRate,
        uint256 _gnin,
        uint256 _deadRate
    ) external returns (address);
}
