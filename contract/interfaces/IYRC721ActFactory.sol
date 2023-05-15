// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC721ActFactory {
    function isAct(address _act) external view returns (bool);

    function getAct(address _nftAddr) external view returns (address);

    function start(address nftAddr) external;
}
