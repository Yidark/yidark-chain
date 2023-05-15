// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface ILockUpFactory {
    function start(
        address _token,
        address _toAddress,
        uint256 _total,
        uint256 _startTime,
        uint256 _intervalTime,
        uint256 _phase
    ) external;

    function starts(
        address _token,
        address[] memory _toAddresies,
        uint256[] memory _totals,
        uint256 _startTime,
        uint256 _intervalTime,
        uint256 _phase
    ) external;

    function startYDK(
        address _toAddress,
        uint256 _startTime,
        uint256 _intervalTime,
        uint256 _phase
    ) external payable;

    function starsYDK(
        address[] memory _toAddresies,
        uint256[] memory _totals,
        uint256 _startTime,
        uint256 _intervalTime,
        uint256 _phase
    ) external payable;

    function wydkAddr() external view returns (address);
}
