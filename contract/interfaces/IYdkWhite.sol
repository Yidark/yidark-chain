// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IYdkWhite {
    function isWhite(address _addr) external view returns (bool);

    function isBlack(address _addr) external view returns (bool);

    function icoFactoryAddr() external view returns (address);

    function yrc20FactoryAddr() external view returns (address);

    function yrc721FactoryAddr() external view returns (address);

    function yrc721ActAddr() external view returns (address);

    function yrc313FactoryAddr() external view returns (address);

    function yrc313ItemFactoryAddr() external view returns (address);

    function yrc313OrderFactoryAddr() external view returns (address);

    function rewardAddr() external view returns (address);

    function wydkAddr() external view returns (address);

    function yusdAddr() external view returns (address);

    function ynsAddr() external view returns (address);

    function routerAddr() external view returns (address);

    function lockUpAddr() external view returns (address);

    function randAddr() external view returns (address);

    function yrc721CreateAddr() external view returns (address);

    function yrc721TradeMainFactoryAddr() external view returns (address);

    function yrc721TradeFactoryAddr() external view returns (address);

    function yrc721AuctionFactoryAddr() external view returns (address);

    function yrc721BlindBoxFactoryAddr() external view returns (address);

    function yrc721MiningFactoryAddr() external view returns (address);

    function multipleWalletFactoryAddr() external view returns (address);

    function yrc927FactoryAddr() external view returns (address);

    function yrc927TradeFactoryAddr() external view returns (address);
}
