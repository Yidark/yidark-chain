// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./libraries/SafeMath.sol";
import "./libraries/Ownable.sol";
import "./libraries/LockFun.sol";
import "./libraries/TransferHelper.sol";
import "./interfaces/IERC20.sol";
import "./interfaces/IAuxiliaryValidator.sol";

contract AuxiliaryActivity is Ownable, LockFun {
    using SafeMath for uint256;
    address public receiptAddr = 0x69BE57e6049f42866465e15d4E4a169d6400Fbed; // 价格
    address public yusdAddr = 0x69BE57e6049f42866465e15d4E4a169d6400Fbed; // 价格
    address public auxiliaryAddr = 0x000000000000000000000000000000000000F010; // 价格
    uint256 public price; // 价格
    uint256 public auxiliaryPrice; // 价格

    uint256 public maxPack = 17692;
    uint256 public packTotal;

    receive() external payable {}

    constructor(
        address _yusdAddr,
        address _receiptAddr,
        address _auxiliaryAddr
    ) {
        yusdAddr = _yusdAddr;
        receiptAddr = _receiptAddr;
        auxiliaryAddr = _auxiliaryAddr;
        price = 199 * (10**IERC20(yusdAddr).decimals());
        auxiliaryPrice = 3900 ether;
    }

    function start(address _owner) public virtual onlyLock {
        _receipt();
        IAuxiliaryValidator(auxiliaryAddr).buy{value: auxiliaryPrice}(_owner);
    }

    function actSell() public view returns (bool) {
        return packTotal >= maxPack;
    }

    function startWithParent(address _owner, address _parent)
        public
        virtual
        onlyLock
    {
        require(_owner == _msgSender(), "AuxiliaryActivity: use Owner");
        _receipt();
        IAuxiliaryValidator(auxiliaryAddr).buyWithParent{value: auxiliaryPrice}(
            _owner,
            _parent
        );
    }

    function _receipt() private {
        require(packTotal < maxPack, "AuxiliaryActivity: Has been sold out");
        IERC20 token = IERC20(yusdAddr);
        require(
            token.allowance(_msgSender(), address(this)) >= price,
            "AuxiliaryActivity: Please authorize"
        );
        // token.transferFrom(_msgSender(), receiptAddr, price);
        TransferHelper.safeTransferFrom(
            yusdAddr,
            _msgSender(),
            receiptAddr,
            price
        );
        packTotal = packTotal + 1;
    }
}
