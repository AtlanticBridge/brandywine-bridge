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
        url: process.env.ALCHEMY_MAINNET_RPC_URL
      }
    },
    kovan: {
      url: process.env.KOVAN_RPC_URL,
      accounts: [process.env.KOVAN_PRIVATE_KEY]
    }
  },
  solidity: "0.7.3",
};

// --- Alternative to the Configuration Defined Above ---
// const config: HardhatUserConfig {
// }

// export default config;
