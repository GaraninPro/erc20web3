// SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployMyToken} from "../script/DeployMyToken.s.sol";
import {MyToken} from "../src/MyToken.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract MyTokenTest is StdCheats, Test {
    MyToken public myToken;
    DeployMyToken public deployToken;
    uint256 public constant STARTING_BALANCE = 100 ether; // 100 000000000000000000

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");
    address public deployerAddress;

    function setUp() public {
        deployToken = new DeployMyToken();
        myToken = deployToken.run();
        deployerAddress = vm.addr(deployToken.deployerKey());
        console.log("Tuk-tuk BITCHES", deployerAddress);
        console.log("Testing address", address(this));
        console.log("Msender1", msg.sender);
        // console.log("My bitch 2 !", msg.sender, msg.sender.balance);
        // console.log("Address of testing contract is ", address(this));
        vm.prank(deployerAddress);
        console.log("Msender2", msg.sender);
        myToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public {
        assertEq(STARTING_BALANCE, myToken.balanceOf(bob));
    }

    function testAllowanceWorks() public {
        uint256 initialAllowance = 50 ether;

        vm.prank(bob);
        myToken.approve(alice, initialAllowance);

        uint256 transferAmount = 25 ether;

        vm.prank(alice);

        myToken.transferFrom(bob, alice, transferAmount);

        assertEq(myToken.balanceOf(alice), transferAmount);
        assertEq(myToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }
}
