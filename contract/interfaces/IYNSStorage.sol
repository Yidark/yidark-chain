// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYNSStorage {
    function getIndex() external returns (uint256);

    function setAttr(
        uint256 index,
        string memory _attr,
        string memory _value
    ) external;

    function setAddr(uint256 index, address addr_) external;

    function getAttr(uint256 index, string memory _attr)
        external
        view
        returns (string memory);

    function getAttrName(uint256 index, uint256 _attr)
        external
        view
        returns (string memory);

    function getAttrByUint256(uint256 index, uint256 _attr)
        external
        view
        returns (string memory);

    function getAddr(uint256 index) external view returns (address);
}
