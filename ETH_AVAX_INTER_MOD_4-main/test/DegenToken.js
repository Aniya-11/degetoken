const { ethers } = require("hardhat");

describe("DegenToken", function () {
  let DegenToken, degenToken, owner, addr1, addr2;

  beforeEach(async function () {
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
    DegenToken = await ethers.getContractFactory("DegenToken");
    degenToken = await DegenToken.deploy();
    await degenToken.deployed();
  });

  it("should mint tokens correctly", async function () {
    await degenToken.mint(addr1.address, 100);
    const balance = await degenToken.balanceOf(addr1.address);
    if (balance.toString() !== "100") {
      throw new Error(`Expected balance to be 100 but got ${balance}`);
    }
  });

  it("should transfer tokens correctly", async function () {
    await degenToken.mint(addr1.address, 100);
    await degenToken.connect(addr1).transfer(addr2.address, 50);
    const balance1 = await degenToken.balanceOf(addr1.address);
    const balance2 = await degenToken.balanceOf(addr2.address);
    if (balance1.toString() !== "50" || balance2.toString() !== "50") {
      throw new Error(`Expected balances to be 50 but got ${balance1} and ${balance2}`);
    }
  });

  it("should burn tokens correctly", async function () {
    await degenToken.mint(addr1.address, 100);
    await degenToken.connect(addr1).burn(20);
    const balance = await degenToken.balanceOf(addr1.address);
    if (balance.toString() !== "80") {
      throw new Error(`Expected balance to be 80 but got ${balance}`);
    }
  });

  it("should redeem tokens correctly", async function () {
    await degenToken.mint(addr1.address, 100);
    await degenToken.connect(addr1).redeem(1);
    const balance = await degenToken.balanceOf(addr1.address);
    if (balance.toString() !== "80") {
      throw new Error(`Expected balance to be 80 but got ${balance}`);
    }
    const redeemedItems = await degenToken.getRedeemedItems(addr1.address);
    if (redeemedItems.length !== 1 || redeemedItems[0] !== "Silver Loot Box") {
      throw new Error(`Expected redeemed item to be "Silver Loot Box" but got ${redeemedItems}`);
    }
  });

  it("should check balance correctly", async function () {
    await degenToken.mint(addr1.address, 100);
    const balance = await degenToken.checkBalance(addr1.address);
    if (balance.toString() !== "100") {
      throw new Error(`Expected balance to be 100 but got ${balance}`);
    }
  });
});
