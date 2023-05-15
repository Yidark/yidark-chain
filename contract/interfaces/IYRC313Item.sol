// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC313Item {
    function factoryAddr() external view returns (address);

    function storeAddr() external view returns (address);

    function sendItemTime() external view returns (uint256);

    function successBonus(address _owner, uint256 _total) external;

    function setBuyerCredit(
        address _addr,
        uint256 _total,
        bool _add
    ) external;

    function setStoreCredit(uint256 _total, bool _add) external;
}
