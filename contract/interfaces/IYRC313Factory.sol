// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC313Factory {
    function isStore(address _store) external view returns (bool);

    function palmMinRate() external view returns (uint256);

    function itemMinRate() external view returns (uint256);

    function maxSendItemTime() external view returns (uint256);

    function receiveTime() external view returns (uint256);

    function minBrun() external view returns (uint256);

    function minNodeRewarwd() external view returns (uint256);

    function yusdAddr() external view returns (address);

    function wydkAddr() external view returns (address);

    function routerAddr() external view returns (address);

    function rewardAddr() external view returns (address);

    function setPalm(address _palmAddr) external;

    function setItem(address _itemAddr) external;

    function isPalm(address _palm) external view returns (bool);

    function isItem(address _item) external view returns (bool);

    function icoFactoryAddr() external view returns (address);

    function yrc20FactoryAddr() external view returns (address);

    function yrc313ItemFactoryAddr() external view returns (address);

    function yrc313OrderFactoryAddr() external view returns (address);

    function arbitrationAddr() external view returns (address);

    function setStoreCredit(
        address _addr,
        uint256 _total,
        bool _add
    ) external;

    function setBuyerCredit(
        address _addr,
        uint256 _total,
        bool _add
    ) external;
}
