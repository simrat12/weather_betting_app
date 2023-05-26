// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./TestToken.sol";


contract MockWeatherNode {
    uint256 public temperature;

    AggregatorV3Interface internal priceFeed;
    TestToken internal testToken;

    mapping(bytes32 => address) public requesters;

    event RequestedWeatherData(bytes32 requestId);
    event FulfilledWeatherData(bytes32 requestId, uint256 temperature);

    constructor(address _priceFeed, address _testToken) {
        priceFeed = AggregatorV3Interface(_priceFeed);
        testToken = TestToken(_testToken);
    }


    function requestWeatherData() public returns (bytes32 requestId) {
        // Simulate the payment of Test tokens.
        require(testToken.transferFrom(msg.sender, address(this), 1 ether), "Payment of Test tokens failed.");

        // Generate a request ID.
        requestId = keccak256(abi.encodePacked(msg.sender, block.timestamp));

        // Store the requester's address.
        requesters[requestId] = msg.sender;

        emit RequestedWeatherData(requestId);

        return requestId;
    }

    function fulfillWeatherData(bytes32 _requestId, uint256 _temperature) public {
        // Check that the function is called by the original requester.
        require(msg.sender == requesters[_requestId], "Only the original requester can fulfill the weather data request.");

        temperature = _temperature;

        emit FulfilledWeatherData(_requestId, _temperature);
    }
}
