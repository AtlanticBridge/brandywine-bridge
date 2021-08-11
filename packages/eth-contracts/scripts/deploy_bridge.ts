import { Contract } from "@ethersproject/contracts";
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

    // --- PUT ORACLE ADDRESS HERE ---
    const oracleAddress = "XYZ"     // deployed to Kovan with Remix
    const jobid = ""                // initial jobid for the Chainlink node job.


    const [deployer] = await ethers.getSigners()
    console.log(
        "Deploying the contracts with the account:",
        await deployer.getAddress()
    );
    
    // ==============================
    // --- DEPLOY BRIDGE CONTRACT ---
    // ==============================
    console.log("Getting artifacts together for Bridge Contract...")
    const Bridge = await ethers.getContractFactory("Bridge")

    console.log("Deploying Bridge Contract...")
    const bridge = await Bridge.deploy()
    await bridge.deployed()

    // --- Contract Infomation ---
    var BridgeAddress = bridge.address

    console.log("Bridge Address: ", bridge.address)

    // =========================================
    // --- DEPLOY CHAINLINK REQUEST CONTRACT ---
    // =========================================
    console.log("Getting artifacts together for Bridge Contract...")
    const ChainlinkRequest = await ethers.getContractFactory("ChainlinkRequest")

    console.log("Deploying Chainlink Request Contract...")
    const chainlinkRequest = await ChainlinkRequest.deploy()
    await chainlinkRequest.deployed()

    // --- Contract Infomation ---
    var ChainlinkRequestAddress = chainlinkRequest.address

    console.log("ChainlinkRequest Address: ", chainlinkRequest.address)
}