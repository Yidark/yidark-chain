// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "./IERC721Enumerable.sol";

/**
 * @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
interface IGodzilla2dERC721 is IERC721Enumerable {
    function mint(
        address account,
        uint256 tokenId,
        uint256[] memory attrs
    ) external;

    function mints(
        address account,
        uint256[] memory tokenIds,
        uint256[] memory attrs
    ) external;

    function burn(uint256 tokenId) external returns (bool);

    function startTokenURI(uint256 tokenId, string memory _url)
        external
        returns (bool);

    function godzillaInfo(uint256 tokenId)
        external
        view
        returns (
            uint16,
            uint16,
            uint16,
            address,
            uint256
        );

    function godzillaInfoStaking(uint256 tokenId)
        external
        view
        returns (uint16, uint16);

    function godzillaInitAddress(uint256 tokenId)
        external
        view
        returns (address);
}
