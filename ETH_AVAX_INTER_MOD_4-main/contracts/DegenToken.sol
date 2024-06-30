// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable(msg.sender) {
  constructor() ERC20("Degen", "DGN") {}

  // Store item structure
  struct StoreItem {
    string itemName;
    uint256 price;
  }

  // Store items list
  StoreItem[] public storeItems;

  // Mapping for user experience (UX) points
  mapping(address => uint256) public xp;

  // Add store items (onlyOwner)
  function addStoreItem(string memory itemName, uint256 price) external onlyOwner {
    storeItems.push(StoreItem(itemName, price));
  }

  // Earn XP for playing games ( onlyOwner can set rewards )
  function awardXP(address player, uint256 amount) public onlyOwner {
    xp[player] += amount;
  }

  // Modifier to restrict functions to players with enough XP
  modifier requiresXP(uint256 minXP) {
    require(xp[msg.sender] >= minXP, "Not enough XP to perform this action");
    _;
  }

  // Mint tokens based on XP (requiresXP)
  function mintForXP(uint256 amount) public requiresXP(amount * 10) {
    _mint(msg.sender, amount);
  }

  // Mint new tokens and distribute them to players as rewards. Only the owner can do this.
  function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
  }

  // Transfer tokens from the sender's account to another account.
  function transferTokens(address to, uint256 amount) external {
    require(balanceOf(msg.sender) >= amount, "Don't have enough Degen Tokens");
    _transfer(msg.sender, to, amount);
  }

  // Redeem tokens for items in the in-game store based on the store item index.
  event RedeemItem(address indexed player, string itemName, uint256 price);

  function redeem(uint256 itemIndex) public virtual {
    require(itemIndex < storeItems.length, "Invalid store item index");
    uint256 price = storeItems[itemIndex].price;
    require(balanceOf(msg.sender) >= price, "Not enough Degen Tokens to redeem this item");

    _burn(msg.sender, price);
    emit RedeemItem(msg.sender, storeItems[itemIndex].itemName, price);
  }

  // Anyone can burn their own tokens that are no longer needed.
  function burn(uint256 amount) public virtual {
    _burn(msg.sender, amount);
  }
}

contract StoreInitializer {
  // Deploy the DegenToken contract and add examples to storeItems
  constructor() {
    DegenToken token = new DegenToken();

    // Add examples to storeItems
    token.addStoreItem("Epic Sword of Valor", 100);
    token.addStoreItem("Mystic Potion of Power", 50);
    token.addStoreItem("Legendary Shield of Fortitude", 200);
  }
}
