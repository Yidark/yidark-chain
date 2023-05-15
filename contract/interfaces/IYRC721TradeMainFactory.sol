// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC721TradeMainFactory {
    function tradeType(address _addr) external view returns (uint256);

    function rewardFeeRate() external view returns (uint256);

    function storeFeeRate() external view returns (uint256);

    function saveTokens(
        address owner,
        address[] memory tokens,
        uint256[] memory tokenIds
    ) external;
}
