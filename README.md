
## Team Members

- @Cathy771 - Developer


## Introduction

Our project plans to build a bridge application which allows users to bridge   ERC20 tokens between L2s. We choose to deploy a burn and mint for tokens you   first deploy on different chains and whitelist for your bridge.


## Steps to reproduce
To compile your contracts and start testing, make sure that you have all dependencies installed.

From the root directory run:

```bash
just install
```

to install the [vIBC core smart contracts](https://github.com/open-ibc/vibc-core-smart-contracts) as a dependency.

Additionally Hardhat will be installed as a dev dependency with some useful plugins. Check `package.json` for an exhaustive list.

> Note: In case you're experiencing issues with dependencies using the `just install` recipe, check that all prerequisites are correctly installed. If issues persist with forge, try to do the individual dependency installations...

## ⚙️ Set up your environment variables

Convert the `.env.example` file into an `.env` file. This will ignore the file for future git commits as well as expose the environment variables. Add your private keys and update the other values if you want to customize (advanced usage feature).

```bash
cp .env.example .env
```

## Run-book
1. Contract dependens install, compile and deploy
```
npx hardhat compile
just deploy optimism base
```
2. Copy the result of contract deployed(port address) or go to /config/config.json copy sendUniversalPacket.optimism.portAddr and sendUniversalPacket.base.portAddr
3. Go to /ibc-token-bridge/src/constant.js replace `op_cross_chain_bridge` and `base_cross_chain_bridge` with port address from step 2
4. Go to /artifacts/contracts/BridgeSDK.sol/BridgeSDK.json file to copy ABI
5. Go to /ibc-token-bridge/src/constant.js replace `cross_chain_bridge_abi` with ABI from setp 4
6. clone frontend project
```
npm i
npm run serve
```

## Proof of testnet interaction

After following the steps above you should have interacted with the testnet. You can check this at the [IBC Explorer](https://explorer.ethdenver.testnet.polymer.zone/).

Here's the data of our application:

- Contract (OP Sepolia) : 0xac3d517d5ed9f0715eA067aA0b437A0aF5E28697
- Contract (Base Sepolia): 0xac3d517d5ed9f0715eA067aA0b437A0aF5E28697
- Channel (OP Sepolia): 0xac3d517d5ed9f0715eA067aA0b437A0aF5E28697
- Channel (Base Sepolia): 0xac3d517d5ed9f0715eA067aA0b437A0aF5E28697

- Proof of Testnet interaction:
    - [SendTx](https://optimism-sepolia.blockscout.com/tx/0x9effaf67d7f35cbad354c5ce0f25ade9941615914662d055fee65a88bdba0df8)
    - [RecvTx](https://base-sepolia.blockscout.com/tx/0x9effaf67d7f35cbad354c5ce0f25ade9941615914662d055fee65a88bdba0df8)
    - [Ack](https://base-sepolia.blockscout.com/tx/0x9effaf67d7f35cbad354c5ce0f25ade9941615914662d055fee65a88bdba0df8)

## What we learned

We learned a lot about IBC while using polymer

## Future Improvements

Get more users, users are important
Support ERC721 or 1155, I like these NFTs very much