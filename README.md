# Weather Betting Smart Contracts

This project contains the smart contracts for a decentralized weather betting application. Users can place bets on whether the temperature will be above or below a certain threshold, and the outcome is determined by an off-chain oracle, using a mock Chaninlink type node in order to handle the request.

## Prerequisites

Before running the smart contracts, make sure you have the following software installed:

- Node.js (v14 or higher)
- Hardhat (v2 or higher)

## Installation

Follow these steps to set up the project:

1. Clone the repository:

git clone https://github.com/simrat12/weather_betting_app


2. Install the dependencies:

cd weather-betting
npm install



## Configuration

Before running the smart contracts, you need to configure the contract addresses and other parameters. Update the following files:

1. `hardhat.config.js`: Configure the network settings according to your development setup.

## Deployment

To deploy the smart contracts, follow these steps:

1. Compile the contracts:

npx hardhat compile


2. Migrate the contracts:

npx hardhat run scripts/deploy.js --network <network_name>


Replace `<network_name>` with the name of the network you want to deploy to, such as `localhost` for a local development network.

3. Take note of the deployed contract addresses printed in the console. You will need them for interacting with the contracts.

## Testing
The smart contracts include a test suite to ensure their functionality. To run the tests, execute the following command:


npx hardhat test
License
This project is licensed under the MIT License. See the LICENSE file for details.
