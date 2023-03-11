// SPDX-License Identifier:MIT

pragma solidity 0.5.0;

// Steps to produce the exploit explained:
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
//to =>
// balanceOf[from] -= value

// since we are only sending tokens from a to b in transferFrom we could also check if totalSupply() changes
import "./TokenWhale.sol";

contract TokenWhaleEchidna is TokenWhaleChallenge {
    TokenWhaleChallenge public token;
    address public player;

    constructor() public TokenWhaleChallenge(msg.sender) {
        player = msg.sender;
    }

    function echidna_test_balance() public view returns (bool) {
        return !isComplete();
    }

    function testTransfer(address to, uint256 amount) public {
        // Pre conditions
        // actions
        // Check that isComplete function returns true or false as expected
        assert(!isComplete());
    }
}
