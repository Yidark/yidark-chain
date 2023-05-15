// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IMultipleWalletFactory {
    function isMultipleWallet(address _addr) external view returns (bool);
}
