// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IYRC721 {
    function levelTotal(uint256 level) external view returns (uint256);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function balanceOf(address owner) external view returns (uint256 balance);

    function storeAddr() external view returns (address);

    function bindAct() external;

    function currentTotal() external view returns (uint256);

    function tokenLevels(uint256 _tokenId) external view returns (uint256);

    function uploadType() external view returns (uint256);

    function _status() external view returns (uint8);

    function _isAct() external view returns (bool);

    function adminBalance()
        external
        view
        returns (uint256 retYdk, uint256 miningYdk);

    function nextByAct(uint8 _status_) external;

    function claim(address _owner, uint256 _total)
        external
        returns (uint256 retYdk);

    // function baseTokenIds() external view returns (address);

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function approve(address to, uint256 tokenId) external;

    function getApproved(uint256 tokenId)
        external
        view
        returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;

    function isApprovedForAll(address owner, address operator)
        external
        view
        returns (bool);
}
