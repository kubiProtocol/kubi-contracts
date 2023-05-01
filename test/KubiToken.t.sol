// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/KubiToken.sol";
import "../src/Counter.sol";

contract KubiTokenTest is Test {
    KubiToken public kubi;
    address private owner;
    Counter public counter;
    address alice = address(1);

    function setUp() public {
        owner = msg.sender;
        counter = new Counter();
        counter.setNumber(0);
        kubi = new KubiToken("kubi", "Kb", address(counter));
    }

    function testTotalSupply() public {
        uint256 expectedSupply = 0;
        uint256 actualSupply = kubi.totalSupply();
        assertEq(actualSupply, expectedSupply, "Total supply is incorrect");
    }

    function testMint() public {
        for (uint256 i = 0; i < 100; i++) {
            counter.increment();
        }
        assertEq(counter.number(), 100);
        vm.prank(alice, alice);
        kubi.mintTokens();
        uint256 actualBalance = kubi.balanceOf(alice);
        assertEq(actualBalance, 10, "Balance of owner is incorrect");
    }

    // function testTransfer() public {
    //     address recipient = address(0x123);
    //     uint256 amount = 500 * 10 ** 18;
    //     kubi.transfer(recipient, amount);
    //     uint256 expectedBalance = 500 * 10 ** 18;
    //     uint256 actualBalance = kubi.balanceOf(recipient);
    //     assertEq(actualBalance, expectedBalance, "Transfer did not work");
    // }
}
