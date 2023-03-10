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

    event DebugContractAddress(address);
    event DebugAllowance(string, uint256);
    event DebugPlayerAddress(address);
    event DebugBalanceOfPlayer(uint256);

    constructor() public TokenWhaleChallenge(msg.sender) {
        player = msg.sender;
        // token = new TokenWhaleChallenge[player];
    }
    115792089237316195423570985008687907853269984665640564039457584007913129639935
    33142400404106051133704759621939308311405984918913418251171555742580854485416

    function echidna_test_balance() public view returns (bool) {
        return !isComplete();
    }

    function testTransfer(address to, uint256 amount) public {
        // Pre conditions
        require(to == player);

        // actions
        emit DebugContractAddress(address(this));
        emit DebugPlayerAddress(player);
        // Check that isComplete function returns true or false as expected
        assert(!isComplete());
        emit DebugBalanceOfPlayer(balanceOf[player]);
    }

    function testTransferFrom(address from, address to, uint256 amount) public {
        // Pre conditions
        require(from == address(this));
        require(to == player);

        // actions
        emit DebugContractAddress(address(this));
        emit DebugPlayerAddress(player);
        // Check that isComplete function returns true or false as expected
        assert(!isComplete());
        emit DebugBalanceOfPlayer(balanceOf[player]);
    }

    function testApprove(address spender, uint256 value) public {
        // Pre conditions
        require(spender == player);
        require(msg.sender == address(this));

        // actions
        approve(spender, value);
        emit DebugContractAddress(address(this));
        emit DebugAllowance(
            "allowance contract => player",
            allowance[(address(this))][player]
        );
        emit DebugPlayerAddress(player);
        // Check that isComplete function returns true or false as expected
        assert(!isComplete());
        emit DebugBalanceOfPlayer(balanceOf[player]);
    }
}
