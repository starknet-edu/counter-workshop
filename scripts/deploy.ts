// declare & deploy a contract.
// use of OZ deployer
// launch with npx ts-node src/scripts/5.declareDeployContractOZ.ts
// Coded with Starknet.js v5.16.0, Starknet-devnet-rs v0.1.0

import { Account, CallData, Contract, RpcProvider, stark } from "starknet";
import fs from "fs";
import * as dotenv from "dotenv";
import { getCompiledCode } from "./utils";
dotenv.config();

async function main() {
  const provider = new RpcProvider({
    nodeUrl: process.env.RPC_ENDPOINT,
  });

  // initialize existing predeployed account 0 of Devnet
  console.log("ACCOUNT_ADDRESS=", process.env.DEPLOYER_PUBLIC_KEY);
  console.log("ACCOUNT_PRIVATE_KEY=", process.env.DEPLOYER_PRIVATE_KEY);
  const privateKey0 = process.env.DEPLOYER_PRIVATE_KEY ?? "";
  const accountAddress0: string = process.env.DEPLOYER_PUBLIC_KEY ?? "";
  const account0 = new Account(provider, accountAddress0, privateKey0);
  console.log("Account connected.\n");

  // Declare & deploy Test contract in devnet
  let sierraCode, casmCode;

  try {
    ({ sierraCode, casmCode } = await getCompiledCode("counter_Counter"));
  } catch (error: any) {
    console.log("Failed to read contract files");
    process.exit(1);
  }

  const myCallData = new CallData(sierraCode.abi);
  const constructor = myCallData.compile("constructor", {
    initial_counter: 100,
    kill_switch_address:
      "0x05f7151ea24624e12dde7e1307f9048073196644aa54d74a9c579a257214b542",
    initial_owner:
      "0x02f4149ce064a65c6eb965f2b89c0afb3211203c7ab62d7d40b0f0a77e571bfa",
  });
  const deployResponse = await account0.declareAndDeploy({
    contract: sierraCode,
    casm: casmCode,
    constructorCalldata: constructor,
    salt: stark.randomAddress(),
  });
  // In case of constructor, add for example : ,constructorCalldata: [encodeShortString('Token'),encodeShortString('ERC20'),account.address,],

  // Connect the new contract instance :
  const myTestContract = new Contract(
    sierraCode.abi,
    deployResponse.deploy.contract_address,
    provider
  );
  console.log(
    `✅ Contract has been deploy with the address: ${myTestContract.address}`
  );
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
