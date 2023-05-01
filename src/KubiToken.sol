pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    address public otherContract;
    uint256 public tokensPer100Coins = 10;

    constructor(
        string memory name,
        string memory symbol,
        address _otherContract
    ) ERC20(name, symbol) {
        otherContract = _otherContract;
    }

    function mintTokens() public {
        require(
            IERC20(otherContract).balanceOf(address(this)) >= 100 * 10 ** 18,
            "MyToken: insufficient balance in other contract"
        );
        uint256 tokensToMint = tokensPer100Coins *
            (IERC20(otherContract).balanceOf(address(this)) / (100 * 10 ** 18));
        _mint(msg.sender, tokensToMint);
    }
}
