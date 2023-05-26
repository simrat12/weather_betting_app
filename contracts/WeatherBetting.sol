// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./MockWeatherNode.sol";
import "./TestToken.sol";

contract WeatherBetting {
    MockWeatherNode public weatherNode;
    TestToken public testToken;

    struct Bet {
        uint256 temperatureThreshold;
        uint256 amount;
        bool betAbove;
    }

    mapping(address => Bet) public bets;

    constructor(address _weatherNodeAddress, address _testTokenAddress) {
        weatherNode = MockWeatherNode(_weatherNodeAddress);
        testToken = TestToken(_testTokenAddress);
    }

    function placeBet(uint256 _temperatureThreshold, bool _betAbove) public {
        require(testToken.transferFrom(msg.sender, address(this), 1 ether), "Payment of Test tokens failed.");
        bets[msg.sender] = Bet(_temperatureThreshold, 1 ether, _betAbove);
    }

    function requestWeatherData() public returns (bytes32) {
        return weatherNode.requestWeatherData();
    }

    function fulfillWeatherData(bytes32 _requestId, uint256 _temperature) public {
        weatherNode.fulfillWeatherData(_requestId, _temperature);
        
        Bet memory bet = bets[msg.sender];
        if (bet.betAbove && _temperature > bet.temperatureThreshold || 
            !bet.betAbove && _temperature < bet.temperatureThreshold) {
            require(testToken.transfer(msg.sender, bet.amount), "Transfer of Test tokens failed.");
        }
    }
}
