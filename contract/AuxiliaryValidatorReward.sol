// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./libraries/SafeMath.sol";
import "./libraries/LockFun.sol";
import "./interfaces/IAuxiliaryValidator.sol";

contract AuxiliaryValidatorReward is LockFun {
    using SafeMath for uint256;
    address public validatorAddr;

    address payable public deadAddr =
        payable(0x000000000000000000000000000000000000dEaD);

    uint256 public deadRate = 5100;

    mapping(address => uint256) public validatorReward; // 节点奖励暂存

    mapping(address => uint256) public userBonus; //

    event SendParent(
        address indexed owner,
        address indexed parent,
        uint256 amount
    );

    event Send(address indexed owner, uint256 amount);
    event Give(address indexed owner, uint256 amount);

    modifier onlyValidator() {
        require(
            validatorAddr == msg.sender,
            "Ownable: caller is not the owner"
        );
        _;
    }

    function start(address _validatorAddr) external onlyLock {
        require(validatorAddr == address(0), "use Start");
        require(_validatorAddr != address(0), "validatorAddr null");
        validatorAddr = _validatorAddr;
    }

    function send(address _owner) external payable {
        uint256 amount = msg.value;
        // require(amount > 0, "AuxiliaryValidatorReward: min");
        if (amount <= 100) {
            return;
        }

        uint256 deadAmount = amount.mul(deadRate).div(10000);

        deadAddr.transfer(deadAmount); // 销毁

        uint256 _amount = amount.sub(deadAmount);
        address _parent = IAuxiliaryValidator(validatorAddr).parent(_owner);
        bool _ok = IAuxiliaryValidator(validatorAddr).isValidator(_parent);

        // 给上级
        if (_parent != address(0) && _ok) {
            if (userBonus[_owner] > 0) {
                _amount = _amount.add(userBonus[_owner]);
                userBonus[_owner] = 0;
            }
            validatorReward[_parent] = validatorReward[_parent].add(_amount);

            emit SendParent(_owner, _parent, _amount);
        } else {
            // 暂存
            userBonus[_owner] = userBonus[_owner].add(_amount);
            emit Send(_owner, _amount);
        }
    }

    function give(address _owner) external onlyValidator returns (uint256) {
        uint256 _amount = validatorReward[_owner];
        if (_amount > 0) {
            payable(_owner).transfer(_amount); // 转让
            validatorReward[_owner] = 0;
            emit Give(_owner, _amount);
        }
        return _amount;
    }

    function bindParent(
        address _owner,
        address _parent
    ) external onlyValidator {
        uint256 _amount = userBonus[_owner];
        if (_amount > 0) {
            validatorReward[_parent] = validatorReward[_parent].add(_amount);
            userBonus[_owner] = 0;
        }
    }
}
