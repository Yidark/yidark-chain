// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "./Ownable.sol";
import "../interfaces/IAuxiliaryValidatorReward.sol";
import "../interfaces/IYdkWhite.sol";
import "../interfaces/IRouterGetAmount.sol";

abstract contract YdkReward is Ownable {
    uint256 public fee;
    address public whiteAddr;
    IYdkWhite ydkWhite;
    address payable public deadAddr =
        payable(0x000000000000000000000000000000000000dEaD);

    constructor(uint256 fee_, address _whiteAddr) {
        fee = fee_;
        whiteAddr = _whiteAddr;
        ydkWhite = IYdkWhite(_whiteAddr);
    }

    function setFee(uint256 fee_) external onlyOwner {
        fee = fee_;
    }

    function reward(address _owner) internal virtual returns (uint256) {
        uint256 _send = _reward(_owner, fee);
        return _send;
    }

    function rewardWithExit(address _owner) internal virtual returns (uint256) {
        uint256 _send = _reward(_owner, fee);
        if (msg.value > _send) {
            payable(_msgSender()).transfer(msg.value - _send);
        }
        return _send;
    }

    function rewardFee(address _owner, uint256 _fee)
        internal
        virtual
        returns (uint256)
    {
        return _reward(_owner, _fee);
    }

    function rewardFeeWithExit(address _owner, uint256 _fee)
        internal
        virtual
        returns (uint256)
    {
        uint256 _send = _reward(_owner, _fee);
        if (msg.value > _send) {
            payable(_msgSender()).transfer(msg.value - _send);
        }
        return _send;
    }

    function _reward(address _owner, uint256 _fee) private returns (uint256) {
        // [yusdAddr, wydkAddr];
        uint256 sendFee = converYdk(_fee);
        if (sendFee > 0) {
            // 获取当前价格
            require(msg.value >= sendFee, "Fee min");
            IAuxiliaryValidatorReward(IYdkWhite(whiteAddr).rewardAddr()).send{
                value: sendFee
            }(_owner);
            return sendFee;
        }
        return 0;
    }

    function burn(uint256 _fee) internal returns (uint256) {
        uint256 sendFee = converYdk(_fee);
        if (sendFee > 0) {
            require(msg.value >= sendFee, "Fee min");
            deadAddr.transfer(sendFee);
            return sendFee;
        }
        return 0;
    }

    function burn() internal returns (uint256) {
        return burn(fee);
    }

    function burnWithExit() internal returns (uint256) {
        return burnWithExit(fee);
    }

    function burnWithExit(uint256 _fee) internal returns (uint256) {
        uint256 _send = burn(_fee);
        if (msg.value > _send) {
            payable(_msgSender()).transfer(msg.value - _send);
        }
        return _send;
    }

    function converYdk(uint256 _amount) internal view returns (uint256) {
        address[] memory addrs = new address[](2);
        // [yusdAddr, wydkAddr];
        addrs[0] = IYdkWhite(whiteAddr).yusdAddr();
        addrs[1] = IYdkWhite(whiteAddr).wydkAddr();
        if (_amount > 0) {
            // 获取当前价格
            uint256[] memory amounts = IRouterGetAmount(
                IYdkWhite(whiteAddr).routerAddr()
            ).getAmountsOut(_amount, addrs);
            return amounts[1];
        }
        return 0;
    }
}
