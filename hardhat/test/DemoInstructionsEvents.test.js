const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DemoInstructionsEvents", function() {
    let owner;
    let other_addr;
    let demo;

    beforeEach(async function() {
        [owner, other_addr] = await ethers.getSigners();

        const DemoInstructionsEvents = await ethers.getContractFactory(
            "DemoInstructionsEvents",
            owner
        );
        demo = await DemoInstructionsEvents.deploy();
        await demo.deployed();
        console.log("contract successfully deployed", demo.address);
    });

    // util function to send test transaction
    async function sendMoney(sender) {
        const amount = 100;
        const txData = {
            to: demo.address,
            value: amount,
        };
        const tx = await sender.sendTransaction(txData);
        await tx.wait();
        return [tx, amount];
    }

    it("should allow to send money", async function() {
        const [sendMoneyTx, amount] = await sendMoney(other_addr);
        console.log("test transaction executed:", sendMoneyTx);

        // demo balance was changed
        await expect(() => sendMoneyTx).to.changeEtherBalance(demo, amount);

        // events log was emit an event
        const timestamp = (await ethers.provider.getBlock(sendMoneyTx.blockNumber))
            .timestamp;

        await expect(sendMoneyTx)
            .to.emit(demo, "Paid")
            .withArgs(other_addr.address, amount, timestamp);
    });

    // the contract's owner can withdraw the money from his contract
    it("should allow to owner to withdraw funds", async function() {
        const [_, amount] = await sendMoney(other_addr);

        const tx = await demo.withdrawWithModifierAdvanced(owner.address);

        await expect(() => tx).to.changeEtherBalances(
            [demo, owner], [-amount, amount]
        );
    });

    // the contract's owner can withdraw the money from his contract
    it("should not allow to other account to withdraw funds", async function() {
        await sendMoney(other_addr);

        await expect(
            demo.connect(other_addr).withdrawWithModifierAdvanced(other_addr.address)
        ).to.be.revertedWith("you are not an owner of the contract!");
    });
});