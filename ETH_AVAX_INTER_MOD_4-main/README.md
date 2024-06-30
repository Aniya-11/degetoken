# Degen Token Project

## Overview

This project guides you through the following steps:
1. Clone the Repo.
2. Test the smart contract to ensure all tests pass.
3. Deploy the contract to the Avalanche Fuji Testnet.
4. Test the deployed contract on the testnet to ensure all tests pass.
5. Verify the smart contract on Snowtrace.

## Prerequisites

Ensure you have the following installed on your system:
- [Node.js](https://nodejs.org/) (v14 or later)
- [npm](https://www.npmjs.com/) (v6 or later)
- [Hardhat](https://hardhat.org/)
- [MetaMask](https://metamask.io/) browser extension

## Steps


### 1. Clone Repo

1. Clone the forked repository to your local machine:
    ```bash

    cd ETH_AVAX_INTER_MOD_4
    ```
2. Install the project dependencies:
    ```bash
    npm install
    ```

### 2. Test the Smart Contract

1. Run the tests to ensure everything works correctly:
    ```bash
    npx hardhat test
    ```

### 3. Deploy the Contract to Avalanche Fuji Testnet

1. Update `hardhat.config.js` to include the Testnet configuration:
    ```javascript
    require("@nomicfoundation/hardhat-toolbox");
    require('dotenv').config();
    require("@nomiclabs/hardhat-ethers");
    
    const FORK_FUJI = false;
    const FORK_MAINNET = false;
    let forkingData = undefined;
    
    if (FORK_MAINNET) {
      forkingData = {
        url: "https://api.avax.network/ext/bc/C/rpcc",
      };
    }
    if (FORK_FUJI) {
      forkingData = {
        url: "https://api.avax-test.network/ext/bc/C/rpc",
      };
    }
    
    /** @type import('hardhat/config').HardhatUserConfig */
    module.exports = {
      solidity: "0.8.20",
      networks: {
        hardhat: {
          gasPrice: 225000000000,
          chainId: !forkingData ? 43112 : undefined, 
          forking: forkingData,
        },
        snowtrace: {
          url: 'https://api.avax-test.network/ext/bc/C/rpc',
          accounts: ['PRIVATE KEY']
        },
        // Uncomment for test with fuji
        fuji: {
          url: "https://api.avax-test.network/ext/bc/C/rpc",
          gasPrice: 225000000000,
          chainId: 43113,
          accounts: ['PRIVATE KEY'], 
        },
        mainnet: {
          url: "https://api.avax.network/ext/bc/C/rpc",
          gasPrice: 225000000000,
          chainId: 43114,
          accounts: ['PRIVATE KEY'],
        },
        localhost: {
          url: "http://localhost:8545", // Adjust port number if needed
        },
      },
      etherscan: {
        apiKey: 'API KEY', 
        snowtrace: "snowtrace", // apiKey is not required, just set a placeholder
      },
      customChains: [
        {
          network: "snowtrace",
          chainId: 43113,
          urls: {
            apiURL: "https://api.routescan.io/v2/network/testnet/evm/43113/etherscan",
            browserURL: "https://avalanche.testnet.localhost:8080"
          }
        }
      ]
    }

    ```
2. Deploy the contract:
    ```bash
    npx hardhat run scripts/deploy.js --network fuji
    ```

### 4. Test on Testnet

1. Once the contract is deployed, interact with it using a script or through a web3 interface like MetaMask to ensure it functions as expected on the testnet.

### 5. Verify the Smart Contract on Snowtrace

1. Navigate to [Snowtrace](https://testnet.snowtrace.io/).
2. Find your contract using the deployed contract address.
3. Verify the contract by providing the source code and the correct compiler version and settings.


## Help

### Common Issues
- **Compilation Errors**: Ensure the Solidity version specified matches the version set in the Remix compiler.
- **Deployment Errors**: Make sure the selected environment is correct and the contract is compiled without errors.
- **Interaction Errors**: Ensure the address and value inputs are valid, that players are registered, and that sufficient balance exists for burning or transferring tokens.

For detailed debugging and assistance, refer to the Remix documentation or community forums.

## Authors
-Aniya kumari aniyakuamri096@gmail.com
9350132454


## Conclusion

By following these steps, you will have successfully created, tested, deployed, and verified an ERC-20 token named "Degen" with the symbol "DGN" on the Avalanche Fuji Testnet.
