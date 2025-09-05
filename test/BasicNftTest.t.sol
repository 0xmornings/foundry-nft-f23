// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { Test } from "forge-std/Test.sol";
import { DeployBasicNft } from "../script/DeployBasicNft.s.sol";
import { BasicNft } from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;

    address public USER = makeAddr("user");
    string public constant SKELLY =  "ipfs://bafkreiawaebqhaobqelhrb4ub46y4wrzp7qvuxscamqxwtcyc3ihtt7wke";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        // string = array of bytes
        // uint256 bool, address, bytes32
        // for(loop through array) compare the elements
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(SKELLY);

        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(SKELLY)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
}