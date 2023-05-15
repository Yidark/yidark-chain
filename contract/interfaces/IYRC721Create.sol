// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC721Create {
    function start(
        string memory _name,
        string memory _symbol,
        address _factoryAddr,
        bool __isAct,
        uint256 _uploadType,
        uint256 _maxTotal,
        uint256[] memory _levelMaxTotal
    ) external returns (address);
}
