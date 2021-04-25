const { expect } = require("chai");

describe("TargetChitFund", function() {
    it("Trial Testing", async function() {
        const TargetChitFund = await ethers.getContractFactory("TargetChitFund");
        const tcf = await TargetChitFund.deploy();

        await tcf.deployed();

        // Fetchoing addresses
        const [owner, addr1, addr2] = await ethers.getSigners();

        await tcf.createPool(owner.address, 50, 5);
        await tcf.depositAmount(owner.address, 5, 2);
    });
});
