// SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract DeployMyToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY =
        0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployerKey;

    function run() external returns (MyToken) {
        console.log("My bitch  !", msg.sender);
        if (block.chainid == 31337) {
            deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
        } else {
            deployerKey = vm.envUint("KEY2");
        }
        address mr = vm.addr(deployerKey);
        console.log("My name is  ", mr);
        vm.startBroadcast(deployerKey);
        MyToken mt = new MyToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return mt;
    }
}
