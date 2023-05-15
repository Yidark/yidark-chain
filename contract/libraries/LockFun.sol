// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

abstract contract LockFun {
    bool _lock; // 锁

    modifier onlyLock() {
        require(!_lock, "up lock");
        _lock = true;
        _;
        _lock = false;
    }
}
