## 📋 Prerequisites

The repo is **compatible with both Hardhat and Foundry** development environments.

- Have [git](https://git-scm.com/downloads) installed
- Have [node](https://nodejs.org) installed (v18+)
- Have [Foundry](https://book.getfoundry.sh/getting-started/installation) installed (Hardhat will be installed when running `npm install`)
- Have [just](https://just.systems/man/en/chapter_1.html) installed (recommended but not strictly necessary)

You'll need some API keys from third party's:
- [Optimism Sepolia](https://optimism-sepolia.blockscout.com/account/api-key) and [Base Sepolia](https://base-sepolia.blockscout.com/account/api-key) Blockscout Explorer API keys
- Have an [Alchemy API key](https://docs.alchemy.com/docs/alchemy-quickstart-guide) for OP and Base Sepolia

Some basic knowledge of all of these tools is also required, although the details are abstracted away for basic usage.

## 🧰 Install dependencies

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

## Tx hash
Optimism tx hash: 0x9effaf67d7f35cbad354c5ce0f25ade9941615914662d055fee65a88bdba0df8
Base tx hash: 0x9effaf67d7f35cbad354c5ce0f25ade9941615914662d055fee65a88bdba0df8


## portAddr
Op: 0xac3d517d5ed9f0715eA067aA0b437A0aF5E28697
Base: 0xac3d517d5ed9f0715eA067aA0b437A0aF5E28697




