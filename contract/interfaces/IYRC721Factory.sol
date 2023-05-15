// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC721Factory {
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

    function isStore(address _store) external view returns (bool);

    function isYrc721(address _yrc721) external view returns (bool);

    function isMining(address _mining) external view returns (bool);

    function rewardFeeNft(address _owner, uint256 _fee)
        external
        payable
        returns (uint256);

    function baseUrl() external view returns (string memory);

    function createBaseFee() external view returns (uint256);

    function createMoreFee() external view returns (uint256);

    function createOneFee() external view returns (uint256);

    function createSyntFee() external view returns (uint256);

    function createMiningFee() external view returns (uint256);

    function fee() external view returns (uint256);

    function ynsAddr() external view returns (address);

    function randAddr() external view returns (address);

    function yrc721CreateAddr() external view returns (address);

    function prophetAddr() external view returns (address);

    function yrc721ActAddr() external view returns (address);

    function minRoyalty() external view returns (uint256);

    function maxRoyalty() external view returns (uint256);

    function addYrc721(address _addr) external;

    function addMining(address _addr) external;
}
