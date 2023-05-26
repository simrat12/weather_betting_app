const { ethers } = require("hardhat");

async function main() {
  try {
    // Get the deployed contract
    const WeatherBetting = await ethers.getContractFactory("WeatherBetting");
    const weatherBetting = await WeatherBetting.attach("<weather_betting_address>");

    // Interact with the contract
    const accounts = await ethers.getSigners();
    const better = accounts[0]; // Update with the desired account

    // Example usage: Place a bet
    const temperatureThreshold = 25; // Update with the desired temperature threshold
    const betAbove = true; // Update with the desired bet direction

    const tx = await weatherBetting.connect(better).placeBet(temperatureThreshold, betAbove);
    await tx.wait();

    console.log("Bet placed successfully");
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

// Run the interact script
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});
