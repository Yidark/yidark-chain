// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC313OrderFactory {
    function start(uint256 _total, address buyer) external returns (address);
}
