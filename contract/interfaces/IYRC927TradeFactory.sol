// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC927TradeFactory {
    function isTrade(address _token, address _owner)
        external
        view
        returns (bool);

    function rewardFee() external view returns (uint256);

    function sendYrc927(
        address _yrc927,
        address _from,
        address _to,
        uint256 _amount
    ) external;

    function finishTrade(address _yrc927, address _from) external;
}
