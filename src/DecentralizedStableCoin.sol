// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
// Layout of contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declaration
// state variables
// events
// modifiers
// functions

// Layout of functions
// constructor
// receive function(if exists)
// fallback function(if exists)
// external
// public
// internal
// private

/// @title DecentralizedStableCoin
/// @author Chinedu Jeremiah
/// Collateral: Exogenous (ETH & BTC)
/// Minting: Algorithm
/// Relative Stability: Pegged to USD
/// 
/// @dev This is the contract meant to be governed by DSCEngine. This contract is just the ERC2O implementation of our stable coin system.

contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    error DecentralizedStableCoin__MustBeMoreThanZero();
    error DecentralizedStableCoin__BurnAmountExceedsBalance();
    error DecentralizedStableCoin__NotZeroAddress();

    constructor()ERC20("DecentralizedStableCoin", "DSC"){

    }

    function burn(uint256 _amount) public override onlyOwner{
        uint256 balance = balanceOf(msg.sender);
        if (_amount  <= 0){
            revert DecentralizedStableCoin__MustBeMoreThanZero();
        }

        if( balance < _amount){
            revert DecentralizedStableCoin__BurnAmountExceedsBalance();
        }

        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns(bool) {
        if (_to == address(0)){
            revert DecentralizedStableCoin__NotZeroAddress();
        }

        if (_amount <= 0) {
            revert DecentralizedStableCoin__MustBeMoreThanZero();
        }

        _mint(_to, _amount);
        return true;
    }
}