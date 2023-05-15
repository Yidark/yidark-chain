// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./libraries/SafeMath.sol";
import "./libraries/LockFun.sol";
import "./interfaces/IYdkWhite.sol";
import "./interfaces/IAuxiliaryValidatorReward.sol";
import "./interfaces/IAuxiliaryActivity.sol";

contract AuxiliaryValidator is LockFun {
    using SafeMath for uint256;
    bool public initialized;
    address public rewardAddr; // 价格
    address public whiteAddr; // 价格
    address public activityAddr; // 价格
    address payable public deadAddress; // 价格
    uint256 public price; // 价格
    uint256 public releaseTotal; // 释放天数
    uint256 public childPackAddRelease; // 推荐多少可以加速一次

    // 节点奖励配置
    uint256 public minerMaxReward;
    uint256 public minerMinReward;
    uint256 public downBlock;
    uint256 public packTotal;
    uint256 public totalRecommendReward;

    mapping(address => UserInfo) public users; //

    event Buy(address indexed owner, uint256 tokenId);

    event BindParent(address indexed owner, address indexed parent);

    event Verify(address indexed owner, uint256 rewards);

    struct Pack {
        uint256 tokenId; // 编号
        uint256 buyTime; // 购买时间
        uint256 total; // 剩余释放次数
    }
    struct UserInfo {
        address parent;
        uint256 childPack; // 推荐下级 购买量
        uint256 lastTime; // 上次点击时间
        uint256 totalReward; // 奖励总额
        uint256 totalRecommendReward; // 推荐奖励总额
        bool isValidator;
        Pack[] packs;
    }

    receive() external payable {}

    modifier onlyNotInitialized() {
        require(!initialized, "Already initialized");
        _;
    }

    modifier onlyInitialized() {
        require(initialized, "Not init yet");
        _;
    }

    function initialize() external onlyNotInitialized {
        price = 3900 ether;
        releaseTotal = 1095;
        childPackAddRelease = 10;
        deadAddress = payable(0x000000000000000000000000000000000000dEaD);
        minerMaxReward = 37;
        minerMinReward = 4;
        downBlock = 15768000;
        initialized = true;
    }

    function start(
        address _rewardAddr,
        address _whiteAddr,
        address _activityAddr
    ) external {
        require(rewardAddr == address(0), "use Start");
        require(_rewardAddr != address(0), "rewardAddr null");
        require(_whiteAddr != address(0), "whiteAddr Null");
        rewardAddr = _rewardAddr;
        whiteAddr = _whiteAddr;
        activityAddr = _activityAddr;
    }

    // 获取上级信息
    function isValidator(address _owner) public view returns (bool) {
        return users[_owner].isValidator;
    }

    // 获取上级信息
    function parent(address _owner) public view returns (address) {
        return users[_owner].parent;
    }

    // 基础资料
    function info(
        address add
    ) public view returns (address, bool, uint256[] memory, bool) {
        UserInfo memory u = users[add];
        uint256[] memory m = new uint256[](5);
        m[0] = u.childPack;
        m[1] = u.lastTime;
        m[2] = u.totalReward;
        m[3] = u.totalRecommendReward;
        m[4] = packTotalByAdd(add);
        return (
            u.parent,
            u.isValidator,
            m,
            byDay(u.lastTime) == byDay(block.timestamp)
        );
    }

    // 配套详情
    function packTotalByAdd(address add) private view returns (uint256) {
        UserInfo memory u = users[add];
        uint256 total;
        for (uint256 i = 0; i < u.packs.length; i++) {
            if (u.packs[i].total > 0) {
                total = total + 1;
            }
        }
        return (total);
    }

    // 配套详情
    function packInfo(
        address add
    )
        public
        view
        returns (uint256[] memory, uint256[] memory, uint256[] memory)
    {
        uint256[] memory tokenId = new uint256[](users[add].packs.length);
        uint256[] memory buyTime = new uint256[](users[add].packs.length);
        uint256[] memory totals = new uint256[](users[add].packs.length);
        for (uint256 i = 0; i < users[add].packs.length; i++) {
            tokenId[i] = users[add].packs[i].tokenId;
            totals[i] = users[add].packs[i].total;
            buyTime[i] = users[add].packs[i].buyTime;
        }
        return (tokenId, totals, buyTime);
    }

    // 配套详情
    function packValidTotal(
        address add
    ) public view returns (uint256 total, uint256 sumTotal) {
        for (uint256 i = 0; i < users[add].packs.length; i++) {
            if (users[add].packs[i].total > 0) {
                total = total.add(1);
                sumTotal = sumTotal.add(users[add].packs[i].total);
            }
        }
    }

    function isParent(
        address _owner,
        address _parent
    ) private view returns (bool) {
        if (_owner == address(0) || _parent == address(0)) {
            return false;
        }
        if (_owner == _parent) {
            return false;
        }

        for (uint256 i = 0; i < 3; i++) {
            if (users[_owner].parent == _parent) {
                return true;
            }
            _owner = users[_owner].parent;
        }
        return false;
    }

    // 购买
    function buy(address owner) external payable onlyInitialized onlyLock {
        _buy(owner);
    }

    // 购买并绑定上级
    function buyWithParent(
        address owner,
        address _parent
    ) external payable onlyInitialized onlyLock {
        _bindParent(owner, _parent);
        _buy(owner);
    }

    //  绑定上级
    function bindParent(
        address owner,
        address _parent
    ) external onlyInitialized onlyLock {
        _bindParent(owner, _parent);
    }

    // 绑定上级
    function _bindParent(address owner, address _parent) private {
        require(
            owner == msg.sender || IYdkWhite(whiteAddr).isWhite(msg.sender),
            "AuxiliaryValidator: Not Auth Bind Parent"
        );
        require(
            users[owner].parent == address(0) &&
                _parent != owner &&
                !isParent(_parent, owner),
            "AuxiliaryValidator: Parent Error"
        );
        if (users[_parent].isValidator) {
            users[owner].parent = _parent;
            IAuxiliaryValidatorReward(rewardAddr).bindParent(owner, _parent);
            emit BindParent(owner, _parent);
        }
    }

    // 购买
    function _buy(address owner) private {
        uint256 hb = msg.value;
        require(hb >= price, "AuxiliaryValidator: Price Error");
        require(isBuy(), "AuxiliaryValidator: Not Buy");
        deadAddress.transfer(hb); // 销毁

        require(
            users[owner].packs.length < 500,
            "AuxiliaryValidator: single max 500"
        );

        users[owner].packs.push(
            Pack(packTotal.add(1), block.timestamp, releaseTotal)
        );

        if (
            users[owner].parent != address(0) &&
            users[users[owner].parent].isValidator
        ) {
            users[users[owner].parent].childPack = users[users[owner].parent]
                .childPack
                .add(1);
        }

        // if (users[owner].lastTime == 0) {
        //     users[owner].lastTime = block.timestamp;
        // }
        packTotal = packTotal.add(1);
        users[owner].isValidator = true;
        emit Buy(owner, packTotal);
    }

    // 验证节点
    function verify() external onlyInitialized onlyLock {
        address owner = msg.sender;
        uint256 lastDay = byDay(users[owner].lastTime);
        uint256 currentDay = byDay(block.timestamp);
        require(lastDay != currentDay, "AuxiliaryValidator: day use verify");

        // 必须卖完之后才开始
        require(
            IAuxiliaryActivity(activityAddr).actSell(),
            "AuxiliaryValidator: not Start"
        );
        users[owner].lastTime = block.timestamp;
        (uint256 totalRewards, uint256 recommendReward) = harvest(owner);
        uint256 sendRewards = 0;
        if (totalRewards > 0) {
            if (address(this).balance > totalRewards) {
                payable(owner).transfer(totalRewards);
                sendRewards = totalRewards;
            } else if (address(this).balance > 0) {
                sendRewards = address(this).balance;
                payable(owner).transfer(address(this).balance);
            }
        }

        users[owner].totalReward = users[owner].totalReward.add(totalRewards);
        users[owner].totalRecommendReward = users[owner]
            .totalRecommendReward
            .add(recommendReward);
        // 总的推荐收益
        totalRecommendReward = totalRecommendReward.add(recommendReward);
        emit Verify(owner, sendRewards);
    }

    // 收获
    function harvest(address owner) private returns (uint256, uint256) {
        uint256 totalRewards = 0;
        uint256 oneRewards = getRewards();
        // uint256 currentDay = byDay(block.timestamp);
        uint256 childSpeedUp = users[owner].childPack.div(childPackAddRelease);
        uint256 maxUp = packTotalByAdd(owner);
        if (childSpeedUp > maxUp) {
            childSpeedUp = maxUp;
        }
        bool isV = false;
        for (uint256 i = 0; i < users[owner].packs.length; i++) {
            Pack memory pack = users[owner].packs[i];
            if (pack.total > 0) {
                totalRewards = totalRewards.add(oneRewards);
                users[owner].packs[i].total = pack.total.sub(1);
                if (
                    childSpeedUp > 0 &&
                    users[owner].packs[i].total >= childSpeedUp
                ) {
                    totalRewards = totalRewards.add(
                        oneRewards.mul(childSpeedUp)
                    );
                    users[owner].packs[i].total = users[owner]
                        .packs[i]
                        .total
                        .sub(childSpeedUp);
                    childSpeedUp = 0;
                }
                if (users[owner].packs[i].total > 0) {
                    isV = true;
                }
            }
        }
        for (uint256 i = 0; i < users[owner].packs.length; i++) {
            Pack memory pack = users[owner].packs[i];
            if (pack.total == 0) {
                users[owner].packs[i] = users[owner].packs[
                    users[owner].packs.length - 1
                ];
                users[owner].packs.pop();
            }
        }
        users[owner].isValidator = isV;
        uint256 recommendReward;
        if (isV) {
            recommendReward = IAuxiliaryValidatorReward(rewardAddr).give(owner);
        }
        return (totalRewards, recommendReward);
    }

    // 当前的收益
    function getRewards() private view returns (uint256) {
        uint256 blockReward = minerMaxReward;
        uint256 number = block.number.div(downBlock).mul(minerMinReward);
        if (blockReward > number) {
            return (blockReward - number).mul(1 ether);
        }
        return 0;
    }

    // 是否可以购买
    function isBuy() private view returns (bool) {
        uint256 blockReward = minerMaxReward;
        uint256 number = block
            .number
            .add(releaseTotal.mul(43200))
            .div(downBlock)
            .mul(minerMinReward);
        if (blockReward > number) {
            return true;
        }
        return false;
    }

    // 获取当天
    function byDay(uint256 time) private pure returns (uint256) {
        return time / 86400;
    }
}
