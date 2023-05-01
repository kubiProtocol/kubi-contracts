pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Counter.sol";

contract KubiToken is ERC20 {
    Counter public otherContract;
    uint256 public tokensPer100Coins = 10;
    uint256 public mintingEventCounter;

    constructor(
        string memory name,
        string memory symbol,
        address _otherContract
    ) ERC20(name, symbol) {
        otherContract = Counter(_otherContract);
        mintingEventCounter = 0;
    }

    function mintTokens() public {
        require(
            //IERC20(otherContract).balanceOf(address(this)) >= 100 * 10 ** 18,
            otherContract.number() >= 100 * (mintingEventCounter + 1),
            "KubiToken: insufficient balance in other contract"
        );
        uint256 tokensToMint = (tokensPer100Coins * (otherContract.number())) /
            //     //(IERC20(otherContract).balanceOf(address(this)) / (100 * 10 ** 18));
            (100 * (mintingEventCounter + 1));
        // change msg.sender to be the redistribution smart contract

        _mint(msg.sender, tokensToMint);
        mintingEventCounter++;
        //if this is successful than the other contract should be "reset" probably need a deadline to ensure
        // that each transactions (mint and reset) have the time to be included on-chain to avoid someone calling
        // mint too many times before the reset happens
    }
}
