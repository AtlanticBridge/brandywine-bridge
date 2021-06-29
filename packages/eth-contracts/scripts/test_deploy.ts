import { Contract } from "ethers";
import { artifacts, ethers, network } from "hardhat";


async function main() {
    // This is just a convenience check
    if (network.name === "hardhat") {
      console.warn(
        "You are trying to deploy a contract to the Hardhat Network, which" +
          "gets automatically created and destroyed every time. Use the Hardhat" +
          " option '--network localhost'" 
      );
    }

    const [deployer] = await ethers.getSigners();
    console.log(
        "Deploying the contracts with account: ",
        await deployer.getAddress()
    )

    console.log("Account balance: ", (await deployer.getBalance()).toString());

    // =============================
    // --- DEPLOY TOKEN CONTRACT ---
    // =============================
    console.log('Getting artifacts together for ElrondEth Contract');
    const EthErdToken = await ethers.getContractFactory("ElrondEth");
    console.log('Deploying TokenContract')
    const token = await EthErdToken.deploy();
    await token.deployed();

    saveFrontendFiles(token);

    function saveFrontendFiles(token: Contract) {
        const fs = require("fs");
        const contractDir = __dirname + "/../../bridge-app/src/app/contracts";

        // If the directory does not exist, make it.
        if (!fs.existsSync(contractDir)) {
            fs.mkdirSync(contractDir);
        }

        fs.writeFileSync(
            contractDir + "/lend-contract-address.json",
            JSON.stringify({ Token: token.address }, undefined, 2)
        );

        const TokenArtifact = artifacts.readArtifactSync("Token");

        fs.writeFileSync(
            contractDir + "/ElrondEth.json",
            JSON.stringify(TokenArtifact, null, 2)
        );
    }
}