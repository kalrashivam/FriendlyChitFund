const { expect } = require("chai");

describe("AwesomeToken", function() {
    it("All test cases for my awt", async function() {
        const awesomeToken = await ethers.getContractFactory("AwesomeToken");
        const symbol = 'AWT';
        const name = 'AWESOMEToken';
        let tokenTotal = 100000;
        const awt = await awesomeToken.deploy(tokenTotal);

        await awt.deployed();

        // Get calls for name, symbol, supply
        expect(await awt.name()).to.equal(name);
        expect(await awt.symbol()).to.equal(symbol);
        expect(await awt.totalSupply()).to.equal(tokenTotal)

        // Fetchoing addresses
        const [owner, addr1, addr2] = await ethers.getSigners();

        // balanceOf
        expect(await awt.balanceOf(owner.address)).to.equal(tokenTotal);

        // transfer
        await awt.transfer(addr1.address, 1)
        expect(await awt.balanceOf(addr1.address)).to.equal(1);

        //  approve
        await awt.approve(addr1.address, 3)
        expect(await awt.allowance(owner.address, addr1.address)).to.equal(3);

        // transferFrom
        console.log('After transfer')
        await awt.connect(addr1).transferFrom(owner.address, addr1.address, 1)
        expect(await awt.connect(addr1).balanceOf(addr1.address)).to.equal(2);
        expect(await awt.allowance(owner.address, addr1.address)).to.equal(2);
        console.log(await awt.returnCounts())

        // burn
        console.log('After burn call')
        await awt.burn(addr1.address, 1)
        tokenTotal -= 1;
        console.log(tokenTotal)
        expect(await awt.totalSupply()).to.equal(tokenTotal)
        console.log(await awt.returnCounts())

        // mint
        console.log('After mint call')
        await awt.mint(addr1.address, 1)
        tokenTotal += 1;
        console.log(tokenTotal)
        expect(await awt.totalSupply()).to.equal(tokenTotal)
        console.log(await awt.returnCounts())
    });
});
