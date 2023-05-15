// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IAuxiliaryValidator {
    function buy(address owner) external payable;

    function buyWithParent(address owner, address _parent) external payable;

    function verify() external;

    function parent(address _owner) external returns (address _parent);

    function isValidator(address _owner) external returns (bool _ok);
}
