// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Time-Locked Personal Vault
contract PersonalVault {
    address public owner;
    uint256 public unlockTime;

    event Deposit(address indexed sender, uint256 amount);
    event Withdrawal(address indexed owner, uint256 amount);
    event LockExtended(uint256 previousUnlockTime, uint256 newUnlockTime);

    error FundsLocked();
    error NotOwner();
    error InvalidUnlockTime();
	error NoBalance();
	error TransferFailed();

    constructor(uint256 _unlockTime) {
        if (_unlockTime < block.timestamp)
			revert InvalidUnlockTime();
        owner = msg.sender;
        unlockTime = _unlockTime;
    }

    modifier onlyOwner() {
        if (msg.sender != owner)
			revert NotOwner();
        _;
    }

    function deposit() external payable {
		emit Deposit(msg.sender, msg.value);
    }

    function withdraw() external onlyOwner {
        if (address(this).balance == 0)
            revert NoBalance();
        uint256 currentTime = block.timestamp;
        if (currentTime < unlockTime)
            revert FundsLocked();
        uint256 withdrawAmount = address(this).balance;
        (bool success, ) = owner.call{value: withdrawAmount}("");
        if (!success)
            revert TransferFailed();
		emit Withdrawal(owner, withdrawAmount);
    }

    function extendLock(uint256 newTime) external onlyOwner {
        if (newTime <= unlockTime)
			revert InvalidUnlockTime();
		uint256 previousUnlockTime = unlockTime;
		unlockTime = newTime;
		emit LockExtended(previousUnlockTime, unlockTime);
    }
}
