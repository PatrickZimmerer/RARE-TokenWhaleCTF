// SPDX-License Identifier:MIT

pragma solidity 0.5.0;

// exploit found by echidna explained:
// Step 1: approve Address B for an extremely large number
// Step 2: call transferFrom (as Address B) and transfer 1 - 1000 tokens from the player to ther player
// Step 3 call transfer (as Address B) and transfer any number below MAX_UINT256 - the number you
//        since you transfered before since Address B has now a huge balance thanks to the underflow

// My way:
// Step 1: send 501 of your tokens to address B (just over the half)
// Step 2: approve the player for a number larger than your balance (calling from address B from above)
// Step 3: call transferFrom (as the player) and transfer 500 tokens from address B to address B

// Explained how the exploit takes place:
// TransferFrom checks if the from address has enoguh balance which he has with 501 and checks if the to address balance increases
// which it does because of the underflow that will happen in _transfer which decreases the balance of the player and causes an underflow
// in adition the address B will increase his balance as well to 1001

// How to fix it:
// In solidity < 0.8.0 over & underflows as in this example happen silently, this is being abused here
// we could use SafeMath from Openzeppelin
// we should check that you can't transferFrom address B => address B as well
// also we should make an internal _transferFrom which could change:
// balanceOf[msg.sender] -= value
// to =>
// balanceOf[from] -= value
// since we are only sending tokens from a to b in transferFrom we could also check if totalSupply() changes

import "./TokenWhale.sol";

contract TokenWhaleEchidna is TokenWhaleChallenge {
    TokenWhaleChallenge public token;

    constructor() public TokenWhaleChallenge(msg.sender) {}

    function echidna_test_balance() public view returns (bool) {
        return !isComplete();
    }

    function testTransfer(address, uint256) public view {
        // Pre conditions
        // actions
        // Check that isComplete function returns true or false as expected
        assert(!isComplete());
    }
}
