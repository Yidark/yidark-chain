// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC313Store {
    function isStore(address _store) external view returns (bool);

    function palmMinRate() external view returns (uint256);

    function itemMinRate() external view returns (uint256);

    function yusdAddr() external view returns (address);

    function factoryAddr() external view returns (address);

    function palmAddr() external view returns (address);

    function palmPrice() external view returns (uint256);

    function brunRate() external view returns (uint256);

    function nodeRewardRate() external view returns (uint256);

    function owner() external view returns (address);

    function setPalm(address _palmAddr) external;

    function isPalm(address _palm) external view returns (bool);

    function icoFactoryAddr() external view returns (address);

    function yrc20FactoryAddr() external view returns (address);

    function arbitrationAddr() external view returns (address);

    function nftCardInfo(address _nftAddr)
        external
        view
        returns (uint256, uint256);

    function nftCouponInfo(address _nftAddr)
        external
        view
        returns (uint256, uint256);
}
