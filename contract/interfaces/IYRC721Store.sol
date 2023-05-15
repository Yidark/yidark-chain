// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC721Store {
    function owner() external view returns (address);

    function earnAddr() external view returns (address); 

    function miningAddr() external view returns (address);

    function isYrc721(address _yrc721) external view returns (bool);
}
