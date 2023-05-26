async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const MockWeatherNode = await ethers.getContractFactory("MockWeatherNode");
  const mockWeatherNode = await MockWeatherNode.deploy();
  await mockWeatherNode.deployed();
  console.log("MockWeatherNode deployed to:", mockWeatherNode.address);

  const MyContract = await ethers.getContractFactory("MyContract");
  const myContract = await MyContract.deploy(mockWeatherNode.address);
  await myContract.deployed();
  console.log("MyContract deployed to:", myContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
      console.error(error);
      process.exit(1);
  });

