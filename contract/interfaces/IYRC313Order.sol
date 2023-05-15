// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC313Order {
    function setCardCoupon(
        address _cardAddr,
        address _couponAddr,
        uint256 _couponTokenId
    ) external;

    function setMoney(
        bool _plam,
        uint256 _ensure,
        uint256 _money
    ) external;
}
