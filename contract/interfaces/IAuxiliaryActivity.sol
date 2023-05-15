// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IAuxiliaryActivity {
    function actSell() external returns (bool _ok);
}
