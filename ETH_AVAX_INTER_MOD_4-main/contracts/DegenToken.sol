// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
// Transferring tokens: Players should be able to transfer their tokens to others.
// Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
// Checking token balance: Players should be able to check their token balance at any time.
// Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    address[] private tokenHolders;
    mapping(address => string[]) private itemsRedeemed;
    string[] public redeemableItems;

    
    constructor()
        ERC20("Degen", "DGN")
{       redeemableItems.push("Choose Number respectively starting form 1 "); 
        redeemableItems.push("Silver Loot Box");
        redeemableItems.push("Gold Loot Box");
        redeemableItems.push("Platinum Loot Box");
        }

    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
        
    }

    function getItemNames() public view returns (string[] memory) {
        return redeemableItems;
    }

    function rewardPlayer(address receiver,uint256 amount) public {
        transfer(receiver,amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function redeem(uint256 action) public {
        if (action == 1) {
            require(
                balanceOf(msg.sender) >= 20,
                "Insufficient balance to redeem Sakura"
            );
            _burn(msg.sender, 20);
            itemsRedeemed[msg.sender].push(redeemableItems[1]);
        } else if (action == 2) {
            require(
                balanceOf(msg.sender) >= 50,
                "Insufficient balance to redeem Hinata"
            );
            _burn(msg.sender, 50);
            itemsRedeemed[msg.sender].push(redeemableItems[2]);
        } else if (action == 3) {
            require(
                balanceOf(msg.sender) >= 100,
                "Insufficient balance to redeem Hinata"
            );
            _burn(msg.sender, 100);
            itemsRedeemed[msg.sender].push(redeemableItems[3]);
        } else {
            revert("Invalid action");
        }
    }

    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function getTokenHolders() public view returns (address[] memory) {
        return tokenHolders;
    }

    function getRedeemedItems(address account)
        public
        view
        returns (string[] memory)
    {
        return itemsRedeemed[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool)
    {
        bool success = super.transfer(recipient, amount);
       
        return success;
    }

}
