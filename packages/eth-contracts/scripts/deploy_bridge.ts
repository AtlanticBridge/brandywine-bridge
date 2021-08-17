import { Contract } from "@ethersproject/contracts";
import { artifacts, ethers, network } from "hardhat";


async function main() {

    console.log("|----------------------------------------------------------------------------------------|")
    console.log("|                                                                                        |")
    console.log(`|        A      TTTTTTT  L            A      N       N    TTTTTTT  IIIIIII         CC    |
|       A A        T     L           A A     N N     N       T        I         CC       |
|      A   A       T     L          A   A    N   N   N       T        I      CC          |
|     A  A  A      T     L         A  A  A   N     N N       T        I         CC       |  
|    A       A     T     LLLLLLL  A       A  N       N       T     IIIIIII         CC    |`)
    console.log("|                                                                                        |")
    console.log("|                                                                                        |")
    console.log("|                      !!! ATLANTIC BRIDGE SMART CONTRACTS !!!                           |")
    console.log("|                                                                                        |")
    console.log("|----------------------------------------------------------------------------------------|\n\n")
    
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
        await deployer.getAddress(),
        "\n"
    );
    
    // ==============================
    // --- DEPLOY BRIDGE CONTRACT ---
    // ==============================
    console.log("==================================")
    console.log("|   Setting up Bridge Contract   |")
    console.log("==================================\n")

    const Bridge = await ethers.getContractFactory("Bridge")

    console.log(" 1. Deploying Bridge Contract")
    const bridge = await Bridge.deploy()
    await bridge.deployed()

    // --- Contract Infomation ---
    var BridgeAddress = bridge.address

    console.log("\nBridge Address Deployed at: ", BridgeAddress)


    // =========================================
    // --- DEPLOY CHAINLINK REQUEST CONTRACT ---
    // =========================================
    console.log("\n")
    console.log("===============================")
    console.log("|   Setting up Math Library   |")
    console.log("===============================\n")

    const MathLib = await ethers.getContractFactory("Math")

    console.log(" 1. Deploying Math Contract")
    const mathLib = await MathLib.deploy()
    await mathLib.deployed()

    // --- Contract Infomation ---
    var mathLibAddress = mathLib.address

    console.log("\nMathLib Address Deployed at: ", mathLibAddress)

    // =========================================
    // --- DEPLOY CHAINLINK REQUEST CONTRACT ---
    // =========================================
    console.log("\n")
    console.log("=============================================")
    console.log("|   Setting up Chainlink Request Contract   |")
    console.log("=============================================\n")
    const ChainlinkRequest = await ethers.getContractFactory("ChainlinkRequest", {
        libraries: {
            Math: mathLibAddress
        }
    })

    console.log(" 1. Deploying Chainlink Request Contract")
    const chainlinkRequest = await ChainlinkRequest.deploy()
    await chainlinkRequest.deployed()

    // --- Contract Infomation ---
    var ChainlinkRequestAddress = chainlinkRequest.address

    console.log("\nChainlinkRequest Address: ", ChainlinkRequestAddress)
}

main()
    .then(() => process.exit(0))
    .catch((err) => {
        console.error(err)
        process.exit(1)
    })