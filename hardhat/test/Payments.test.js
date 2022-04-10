const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Payments", function() {
    let acc1, acc2, payments;
    beforeEach(async function() {
        [acc1, acc2] = await ethers.getSigners();
        const Payments = await ethers.getContractFactory("Payments", acc1);
        payments = await Payments.deploy();
        await payments.deployed();
        console.log(payments.address);
    });

    it("should be deployed", async function() {
        console.log("success && properAddress!");
        expect(payments.address).to.be.properAddress;
    });

    it("should have 0 ether by default", async function() {
        const balance = await payments.getCurrentBalance();
        console.log("balance", balance);
        expect(balance).to.eq(0);
    });

    it("should be possible to send funds", async function() {
        const sum = 100
        const payMessage = "hello from hardhat"
        const tx = await payments
            .connect(acc2)
            .pay(payMessage, { value: sum });

        await expect(() => tx).to.changeEtherBalance(acc2, -sum);

        await expect(() => tx).to.changeEtherBalances(
            [acc2, payments], [-sum, sum]
        );
        await tx.wait();
        const balance = await payments.getCurrentBalance();
        console.log("balance", balance);

        const newPayment = await payments.getPayment(acc2.address, 0)
        console.log("newPayment", newPayment)

        expect(newPayment.message).to.eq(payMessage)
        expect(newPayment.amount).to.eq(sum)
        expect(newPayment.from).to.eq(acc2.address)
    });
});