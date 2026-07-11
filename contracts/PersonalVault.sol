// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Time-Locked Personal Vault
/// @notice TODO: implement deposit(), withdraw(), and extendLock() sesuai spesifikasi di README.md
contract PersonalVault {
    address public owner;
    uint256 public unlockTime;

    event Deposit(address indexed sender, uint256 amount);
    event Withdrawal(address indexed owner, uint256 amount);
    event LockExtended(uint256 previousUnlockTime, uint256 newUnlockTime);

    error FundsLocked();
    error NotOwner();
    error InvalidUnlockTime();

    constructor(uint256 _unlockTime) {
        // TODO: validate _unlockTime tidak di masa lalu
        owner = msg.sender;
        unlockTime = _unlockTime;
    }

    modifier onlyOwner() {
        // TODO
        _;
    }

    function deposit() external payable {
        // TODO
    }

    function withdraw() external onlyOwner {
        // TODO
    }

    function extendLock(uint256 newTime) external onlyOwner {
        // TODO
    }
}
