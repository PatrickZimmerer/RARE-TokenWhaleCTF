// SPDX-License Identifier:MIT

pragma solidity 0.5.0;

// exploit explained:
// Step 1: send all your tokens to an arbitrary address
// Step 2: approve the player for an extremely large number (calling from the arbitrary address from above)
// Step 3: call transferFrom (as the player) and transfer all tokens from the arbitrary address to the contract
// Step 4 as the player call transfer/transferFrom and send 0 tokens from the smart contract to the player
// In solidity < 0.8.0 over & underflows as in this example happen silently, this is being abused here, also there is no limit on
// approving a user for max balanceOf[address] so that makes this exploit possible
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
