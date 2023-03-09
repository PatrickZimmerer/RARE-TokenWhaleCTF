// SPDX-License Identifier:MIT

pragma solidity 0.5.0;

import "./TokenWhale.sol";

contract TokenWhaleEchidna {
    address player;
    TokenWhaleChallenge token;

    constructor() public {
        player = msg.sender;
        token = new TokenWhaleChallenge(player);
    }

    function echidna_test_balance() public view returns (bool) {
        return token.balanceOf(player) <= 1000000;
    }
}
