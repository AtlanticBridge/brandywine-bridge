import "@nomiclabs/hardhat-waffle"
import "@nomiclabs/hardhat-ethers"

require('dotenv').config()

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
export default {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      chainId: 1337,
      forking: {
        url: process.env.MAINNET_RPC_URL
      }
    },
    kovan: {
      url: process.env.KOVAN_RPC_URL,
      accounts: [process.env.KOVAN_PRIVATE_KEY]
    }
  },
  solidity: {
    version: "0.6.12"
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 20000
  }
}
