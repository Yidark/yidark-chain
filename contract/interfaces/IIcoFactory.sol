// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IIcoFactory {
    function isIco(address _icoAddr) external view returns (bool);

    function routerAddr() external view returns (address);

    function lockUpAddr() external view returns (address);

    function icoStatus(address _tokenAddr) external view returns (uint256);
}
