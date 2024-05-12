# Starknet's Counter Workshop

In this workshop, you will learn how to create a simple Starknet smart contract, implement public functions, and events, access external contracts, and use OpenZeppelin's Ownable contract.

After completing each step, run the associated script to verify it has been implemented correctly.

Use the [Cairo book](https://book.cairo-lang.org/ch00-00-introduction.html) and the [Starknet docs](https://docs.starknet.io/documentation/) as a reference.

## Setup

Clone this repository and choose whether you prefer using Docker to manage global dependencies or not in the following steps:

### Option 1: Without Docker

1. Install `asdf` ([instructions](https://asdf-vm.com/guide/getting-started.html))
2. Install Scarb `2.6.4` via `asdf` ([instructions](https://docs.swmansion.com/scarb/download.html#install-via-asdf))
3. Install Starknet Foundry `0.23.0` via `asdf` ([instructions](https://foundry-rs.github.io/starknet-foundry/getting-started/installation.html))
4. Install the Cairo 1.0 extension for VSCode ([marketplace](https://foundry-rs.github.io/starknet-foundry/getting-started/installation.html#installation-via-asdf))

### Option 2: With Docker

4. Make sure Docker is installed and running
5. Install the Dev Containers extension for VSCode ([marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers))
6. Launch an instance of VSCode inside of the container by going to **View -> Command Palette -> Dev Containers: Rebuild and Reopen in Container**

> **Note:** All the commands shown from this point on will assume that you are using the integrated terminal of a VSCode instance running inside the container. If you want to run the tests on a different terminal you'll need to use the command `docker compose run test`.

## Step 1

Switch to the `step1` branch to enable the verification tests:

```bash
$ git checkout -b step1 origin/step1
```

### Goal

Initialize the project structure within the cloned repository by using the `Scarb` package manager and enable compilation of Starknet Contracts.

### Requirements

- When initializing the project with `Scarb`, name it as `counter`
- Create a new Cairo file under the `src` directory named `counter.cairo`, and add the following starting code:
  ```rust
  #[starknet::contract]
  mod Counter {
      #[storage]
      struct Storage {}
  }
  ```
- In the `lib.cairo` file remove the code and define the `counter` module

> **Note:** Using any other name will disrupt upcoming steps.

### Verification

When completed, build your project by running the following command:

```bash
scarb build
```

### Hints

- Check out the `scarb init` command to initialize a project. In case you want to initialze the project with a specific name, you can use the `scarb init --name PACKAGE_NAME` command.
- Refer to the [Cheat Sheet](https://docs.swmansion.com/scarb/docs/cheatsheet.html) for essential `Scarb` commands
- To enable Starknet Contract compilation:
  - Target `starknet-contracts`.
  - Specify the Cairo version in the `Scarb.toml`.
  - Learn more in the [Starknet Contract Target](https://docs.swmansion.com/scarb/docs/extensions/starknet/contract-target.html) documentation.

## Step 2

Switch to the `step2` branch to enable the verification tests:

```bash
$ git checkout -b step2 origin/step2
```

### Goal

Add `snforge` as a dependency within your `Scarb.toml` file to allow execution of tests with Starknet Foundry.

### Requirements

- In your `Scarb.toml`, declare the `snforge_std` package as your project dependency and enable `casm` contract class generation
- In your `Scarb.toml`, define a script named `test` to be able to run `snforge test` command

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
scarb test
```

### Hints

- Specify the version of Starknet Foundry that the project currently uses
- Refer to the [Starknet Foundry Documention](https://foundry-rs.github.io/starknet-foundry/getting-started/first-steps.html#using-snforge-with-existing-scarb-projects) for more information.
- Refer to the [Scarb Running Scripts Documentation](https://docs.swmansion.com/scarb/docs/reference/scripts.html#running-scripts) for more information.

## Step 3

Switch to the `step3` branch to enable the verification tests:

```bash
$ git checkout -b step3 origin/step3
```

### Goal

Implement an interface for the contract which contains the `get_counter()` function. This function returns the value of the stored `counter` variable within the contract.

### Requirements

- Implement an interface for a function named `get_counter()` which returns the value of the `counter` variable.
- The `get_counter()` function must be within the contract's interface named `ICounter`.

> **Note:** Any other given name to the contract's interface would break the test, be sure to have to correct name!

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- Storage variables are the most common way to interact with your contract storage. You can read more about it in [Chapter 14 - Contract Storage](https://book.cairo-lang.org/ch14-01-contract-storage.html).
- The constructor function is a special type of function that runs only once. You can read more about it in [Chapter 14 - Constructor Function](https://book.cairo-lang.org/ch14-02-contract-functions.html#1-constructors).
- To create a contract interface, you will need to define a trait with the name `ICounter` (otherwise the tests will fail) and mark the trait with the `[starknet::interface]` attribute. You can read more about it in [Chapter 15 Interfaces](https://book.cairo-lang.org/ch15-01-abis-and-contract-interfaces.html#interface).
- The `get_counter()` function should only be able to read the state of the contract and not modify it. You can read more about it in [Chapter 14 - View functions](https://book.cairo-lang.org/ch14-02-contract-functions.html#view-functions).

## Step 4

Switch to the `step4` branch to enable the verification tests:

```bash
$ git checkout -b step4 origin/step4
```

### Goal

Within the same interface created in the previous step, implement a function called `increase_counter()` that can increment the current value of the `counter` by `1` each time it is invoked.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- The `increase_counter()` function should be able to modify the state of the contract (also called an external function) and update the `counter` value within the `Storage`. You can read more about it in [Chapter 14 - External Functions](https://book.cairo-lang.org/ch14-02-contract-functions.html#external-functions).

## Step 5

Switch to the `step5` branch to enable the verification tests:

```bash
$ git checkout -b step5 origin/step5
```

### Goal

Implement an event named `CounterIncreased` that emits the current value of the `counter` variable, every time the value is increased.

### Requirements

- Define a variant named `CounterIncreased` in the `Event` enum.
- When defining the `counter` variable within the `CounterIncrease` struct, mark it with the `#[key]` attribute.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- Events are custom data structures that are emitted by a contract. More information about Events can be found in [Chapter 14 - Contract Events](https://book.cairo-lang.org/ch14-03-contract-events.html).
- To emit an event, you can use the `self.emit()` function as show [here](https://book.cairo-lang.org/ch14-03-contract-events.html#emitting-events).

---

> **Note:** CHECKPOINT Reached ⛳️! Switch to the `step15-js` branch to get a deployment script based on starknet.js.
>
> ```bash
> git checkout -b step15-js origin/step15-js
> ```

---

## Step 6

Switch to the `step6` branch to enable the verification tests:

```bash
$ git checkout -b step6 origin/step6
```

### Goal

In this step, we will introduce an external smart contract that acts as a kill switch for a specific function. Your task is to add the external `KillSwitch` contract as a dependency within your project.

> **Note:** The `KillSwitch` contract can be found [here](https://github.com/starknet-edu/kill-switch).

### Requirements

- In your `Scarb.toml` file, declare the `kill_switch` package as your project dependency.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- Refer to the [Scarb Managing Dependencies Documention](https://docs.swmansion.com/scarb/docs/guides/dependencies.html) for more information.

## Step 7

Switch to the `step7` branch to enable the verification tests:

```bash
$ git checkout -b step7 origin/step7
```

### Goal

Initialize the `KillSwitch` contract and store the contract's address given by the constructor function.

### Requirements

1. Store a variable named `kill_switch` as type `IKillSwitchDispatcher`.
2. Update the constructor function to initialize the `kill_switch` variable.

> **Note:** Analyze the `KillSwitch` code to understand the interface and the contract structure from [here](https://github.com/starknet-edu/kill-switch/blob/master/src/lib.cairo). This is already added as a dependency in your `Scarb.toml` file.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- You need to import the `Dispatcher` and `DispatcherTrait` of the `KillSwitch` contract. These dispatchers are automatically created and exported by the compiler. More information about Contract Dispatcher can be found in [Chapter 12.5.2 - Contract Dispatcher](https://book.cairo-lang.org/ch15-02-contract-dispatchers-library-dispatchers-and-system-calls.html#contract-dispatcher).
- In the constructor function, you can update the variable `kill_switch` with the `IKillSwitchDispatcher { contract_address: ??? }`, which expects the address of the external contract.

> **Note:** If you want to deploy the `Counter` contract, you can use the following deployed `KillSwitch` contract address.
>
> ## **Sepolia**
>
> Contract Address: `0x05f7151ea24624e12dde7e1307f9048073196644aa54d74a9c579a257214b542`
>
> - [Voyager](https://sepolia.voyager.online/contract/0x05f7151ea24624e12dde7e1307f9048073196644aa54d74a9c579a257214b542)
> - [Starkscan](https://sepolia.starkscan.co/contract/0x05f7151ea24624e12dde7e1307f9048073196644aa54d74a9c579a257214b542)

## Step 8

Switch to the `step8` branch to enable the verification tests:

```bash
$ git checkout -b step8 origin/step8
```

### Goal

Implement the `KillSwitch` mechanism in the `increase_counter()` by calling the `is_active()` function from the `KillSwitch` contract.

### Requirements

- If the function `is_active()` from the KillSwitch contract returns `false`, then allow the `increase_counter()` to increment the value.
- If the function `is_active()` from the KillSwitch contract returns `true`, then return without incrementing the value.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- You can access the `is_active()` function from your `kill_switch` variable. Use this to create the logic in the `increase_counter()` function.

## Step 9

Switch to the `step9` branch to enable the verification tests:

```bash
$ git checkout -b step9 origin/step9
```

### Goal

Add the external `OpenZeppelin` contracts as a dependency within your project.

> **Note:** The `OpenZeppelin` contracts can be found [here](https://github.com/OpenZeppelin/cairo-contracts).

### Requirements

-In your `Scarb.toml` file, declare the `openzeppelin` package as your project dependency.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- Specify the OpenZeppelin `tag` version as `v0.11.0` in `Scarb.toml`.
- Refer to the [OZ Contracts for Cairo Documention](https://docs.openzeppelin.com/contracts-cairo/0.11.0/) for more information.

## Step 10

Switch to the `step10` branch to enable the verification tests:

```bash
$ git checkout -b step10 origin/step10
```

### Goal

Initialize the `Ownable` component from the OpenZeppelin contracts.

Before working on this step, make sure to read [Chapter 16.2: Composability and Components](https://book.cairo-lang.org/ch16-02-00-composability-and-components.html) and see how Components work.

### Requirements

- Declare the component inside your contract using the `component!()` macro.
- Add the path to the component's storage and events to the contract's `Storage` and `Event`.
- Embed the component's logic into your contract by creating an instance of the component's generic implementation with a specific `ContractState`.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- Refer to the [Using Components Inside a Contract](https://book.cairo-lang.org/ch16-02-00-composability-and-components.html#using-components-inside-a-contract) documentation to learn how to implement a component within a contract.

## Step 11

Switch to the `step11` branch to enable the verification tests:

```bash
$ git checkout -b step11 origin/step11
```

### Goal

Modify the constructor function to utilize the `initializer()` function within the `Ownable` component. for initializing the owner.

### Requirements

- The input variable of the constructor function should be named `initial_owner`

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hint

- Refer to the [Ownable Component](https://github.com/OpenZeppelin/cairo-contracts/blob/main/src/access/ownable/ownable.cairo) to learn more about the accessible function.

## Step 12

Switch to the `step12` branch to enable the verification tests
:

```bash
$ git checkout -b step12 origin/step12
```

### Goal

Protect the `increase_counter()` function so that only the owner of the contract can call this.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- Utilize the `assert_only_owner()` function from the [Ownable Component](https://github.com/OpenZeppelin/cairo-contracts/blob/main/src/access/ownable/ownable.cairo).
