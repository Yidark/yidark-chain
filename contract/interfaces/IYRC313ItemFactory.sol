// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC313ItemFactory {
    function start(
        string memory _name,
        string memory _logo,
        uint256 _price,
        uint256 _total
    ) external payable returns (address);
}
