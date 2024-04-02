# Starknet's Counter Workshop

In this workshop, you will learn how to create a simple Starknet smart contract, implement public functions, events, and access external contracts.

After completing each step, run the associated script to verify it has been implemented correctly.

Use the [Cairo book](https://book.cairo-lang.org/ch00-00-introduction.html) and the [Starknet docs](https://docs.starknet.io/documentation/) as a reference.

## Setup

1. Clone this repository
1. Create a new file called `counter.cairo` inside the `src` folder
1. Copy the following code into the file

```rust
#[starknet::contract]
mod Counter {
    #[storage]
    struct Storage {}
}
```

> **Note:** You'll be working on the `counter.cairo` file to complete the requirements of each step. The file `prev_solution.cairo` will show up in future steps as a way to catch up with the workshop if you fall behind. **Don't modify that file**.

The next setup steps will depend on wether you prefer using Docker to manage global dependencies or not.

### Option 1: Without Docker

4. Install Scarb 2.6.3 ([instructions](https://docs.swmansion.com/scarb/download.html#install-via-asdf))
1. Install Starknet Foundry 0.20.0 ([instructions](https://foundry-rs.github.io/starknet-foundry/getting-started/installation.html))
1. Install the Cairo 1.0 extension for VSCode ([marketplace](https://marketplace.visualstudio.com/items?itemName=starkware.cairo1))
1. Run the tests to verify the project is setup correctly

```
$ scarb test
```

### Option 2: With Docker

4. Make sure Docker is installed and running
5. Install the Dev Containers extension for VSCode ([marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers))
6. Launch an instance of VSCode inside of the container by going to **View -> Command Palette -> Dev Containers: Rebuild and Reopen in Container**
7. Open VSCode's integrated terminal and run the tests to verify the project is setup correctly

```bash
$ scarb test
```

> **Note:** All the commands shown from this point on will assume that you are using the integrated terminal of a VSCode instance running inside the container. If you want to run the tests on a different terminal you'll need to use the command `docker compose run test`.

## Step 1

Checkout the `step1` branch to enable the verification tests for this section.

```bash
$ git checkout -b step1 origin/step1
```

### Goal

In this step, you will need to do the following:

1. Store a variable named `counter` as `u32` type in the `Storage` struct.
2. Implement the constructor function that initializes the `counter` variable with a given input value.
3. Implement a public function named `get_counter()` which returns the value of the `counter` variable.

### Requirements

- The `get_counter()` function must be within the contract's interface named `ICounter`.

> **Note:** Any other given name to the contract's interface would break the test, be sure to have to correct name!

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- Storage variables are the most common way to interact with your contract storage. You can read more about it in [Chapter 12.3.1 - Contract Storage](https://book.cairo-lang.org/ch14-01-contract-storage.html).
- The constructor function is a special type of function that runs only once. You can read more about it in [Chapter 12.3.2 - Constructor Function](https://book.cairo-lang.org/ch14-02-contract-functions.html#1-constructors).
- To create a contract interface, you will need to define a trait with the name `ICounter` (otherwise the tests will fail) and mark the trait with the `[starknet::interface]` attribute. You can read more about it in [Chapter 12.5 Interfaces](https://book.cairo-lang.org/ch15-01-abis-and-contract-interfaces.html#interface).
- The `get_counter()` function should only be able to read the state of the contract and not modify it. You can read more about it in [Chapter 12.3.2 - View functions](https://book.cairo-lang.org/ch14-02-contract-functions.html#view-functions).

## Step 2

Checkout the `step2` branch to enable the verification tests for this section.

```bash
$ git checkout -b step2 origin/step2
```

If you fell behind, the file `prev_solution.cairo` contains the solution to the previous step.

### Goal

Implement a function called `increase_counter()` that can increment the current value of the `counter` by `1` each time it is invoked.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- The `increase_counter()` function should be able to modify the state of the contract (also called an external function) and update the `counter` value within the `Storage`. You can read more about it in [Chapter 12.3.2 - External Functions](https://book.cairo-lang.org/ch14-02-contract-functions.html#external-functions).

## Step 3

Checkout the `step3` branch to enable the verification tests for this section.

```bash
$ git checkout -b step3 origin/step3
```

If you fell behind, the file `prev_solution.cairo` contains the solution to the previous step.

### Goal

In this step, you will need to do the following:

1. Import the `KillSwitch` contract interface into your project.
2. Store a variable named `kill_switch` as type `IKillSwitchDispatcher` in the `Storage`.
3. Update the constructor function to receive an additional input variable with the type `ContractAddress`.
4. Update the constructor function to initialize the `kill_switch` variable with the newly added input variable. Note that you need to use the `IKillSwitchDispatcher` which expects a `ContractAddress` as its type.

> **Note:** Analyze the `KillSwitch` code to understand the interface and the contract structure from [here](https://github.com/starknet-edu/kill-switch/blob/master/src/lib.cairo). This is already added as a dependency in your `Scarb.toml` file.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- You need to import `Dispatcher` and `DispatcherTrait` of the KillSwitch contract. These dispatchers are automatically created and exported by the compiler. More information about Contract Dispatcher can be found in [Chapter 12.5.2 - Contract Dispatcher](https://book.cairo-lang.org/ch15-02-contract-dispatchers-library-dispatchers-and-system-calls.html#contract-dispatcher).
- In the constructor, you can update the variable `kill_switch` with the `IKillSwitchDispatcher { contract_address: ??? }`, which expects the address of the external contract.

> **Note:** If you want to deploy the `Counter` contract, you can use the following deployed `KillSwitch` contract address.
>
> ## **Sepolia**
>
> Contract Address: `0x05f7151ea24624e12dde7e1307f9048073196644aa54d74a9c579a257214b542`
>
> - [Voyager](https://sepolia.voyager.online/contract/0x05f7151ea24624e12dde7e1307f9048073196644aa54d74a9c579a257214b542)
> - [Starkscan](https://sepolia.starkscan.co/contract/0x05f7151ea24624e12dde7e1307f9048073196644aa54d74a9c579a257214b542)

## Step 4

Checkout the `step4` branch to enable the verification tests for this section.

```bash
$ git checkout -b step4 origin/step4
```

If you fell behind, the file `prev_solution.cairo` contains the solution to the previous step.

### Goal

Implement the `KillSwitch` mechanism in the `increase_counter()` by calling the `is_active()` function from the `KillSwitch` contract.

### Requirements

- If the function `is_active()` from the KillSwitch contract returns `true`, then allow the `increase_counter()` to increment the value.
- If the function `is_active()` from the KillSwitch contract returns `false`, then return without incrementing the value.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- You can access the `is_active()` function from your `kill_switch` variable. Use this to create the logic in the `increase_counter()` function.

## Step 5

Checkout the `step5` branch to enable the verification tests for this section.

```bash
$ git checkout -b step5 origin/step5
```

If you fell behind, the file `prev_solution.cairo` contains the solution to the previous step.

### Goal

In this step, you will need to do the following:

1. Implement an event named `CounterIncreased` which emits the current value of the `counter`.
2. Emit this event when the `counter` variable has been successfully incremented.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```bash
$ scarb test
```

### Hints

- Events are custom data structures that are emitted by a contract. More information about Events can be found in [Chapter 12.3.3 - Contract Events](https://book.cairo-lang.org/ch14-03-contract-events.html).

## Step 6 (Final)

Checkout the `step6` branch to enable the verification tests for this section.

```bash
$ git checkout -b step6 origin/step6
```

If you fell behind, the file `prev_solution.cairo` contains the solution to the previous step.

### Goal

Check that you have correctly created an account contract for Starknet by running the full test suite:

```bash
$ scarb test
```

If the test suite passes, congratulations, you have created your first Counter Smart Contract on Starknet.
