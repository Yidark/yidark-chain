// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC20Factory {
    function start(
        uint256 _totalSupply,
        uint8 _decimals,
        string memory _name,
        string memory _symbol,
        address _adminAddress,
        uint256 _buyFee,
        uint256 _sellFee,
        uint256 _transferFee,
        uint256 _feeType,
        uint256 _rewardLiquidityRate
    ) external payable;

    function routerAddr() external view returns (address);

    function icoAddr() external view returns (address);

    function yusdAddr() external view returns (address);

    function isToken(address _token) external view returns (bool);
}
