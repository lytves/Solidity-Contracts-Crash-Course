const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DemoInstructionsEvents", function() {
    let owner;
    let other_addr;
    let demo;

    beforeEach(async function() {
        [owner, other_addr] = await ethers.getSigners();

        const DemoInstructionsEvents = await ethers.getContractFactory("DemoInstructionsEvents", owner);
        demo = await DemoInstructionsEvents.deploy();
        await demo.deployed();
        console.log("deployed");
    });

    async function sendMoney(sender) {
        const amount = 100;
        const txData = {
            to: demo.address,
            value: amount
        };
        const tx = await sender.sendTransaction(txData);
        await tx.wait();
        return [tx, amount];
    }

    it("should allow to send money", async function() {
        const [sendMoneyTx, amount] = await sendMoney(other_addr);
        console.log(sendMoneyTx);
    });
});