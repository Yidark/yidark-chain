// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IRandUint {
    function getRand(uint256 min, uint256 max) external returns (uint256);

    function getRand(uint256 max) external returns (uint256);
}
