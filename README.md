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

4. Install Scarb 2.5.1 ([instructions](https://docs.swmansion.com/scarb/download.html#install-via-asdf))
1. Install Starknet Foundry 0.16.0 ([instructions](https://foundry-rs.github.io/starknet-foundry/getting-started/installation.html))
1. Install Nodejs 20 or higher ([instructions](https://nodejs.org/en/))
1. Install the Cairo 1.0 extension for VSCode ([marketplace](https://marketplace.visualstudio.com/items?itemName=starkware.cairo1))
1. Run the tests to verify the project is setup correctly
```
$ scarb test
```

### Option 2: With Docker

4. Make sure Docker is installed and running
4. Install the Dev Containers extension for VSCode ([marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers))
4. Launch an instance of VSCode inside of the container by going to **View -> Command Palette -> Dev Containers: Rebuild and Reopen in Container**
4. Open VSCode's integrated terminal and run the tests to verify the project is setup correctly
```
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

1. store a variable named `counter` as `u32` type in the `Storage` struct;
2. implement the constructor function that initializes the `counter` variable with a given input value;
3. implement a public function named `get_counter()` which returns the value of the `counter` variable;

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```
$ scarb test
```

### Hints

- Storage variables are the most common way to interact with your contract storage, you can read more about it in [Chapter 12.3.1 - Contract Storage](https://book.cairo-lang.org/ch99-01-03-01-contract-storage.html#contract-storage)
- The constructor function is a special type of function that runs only once, you can read more about it in [Chapter 12.3.2 - Constructor Function](https://book.cairo-lang.org/ch99-01-03-02-contract-functions.html#1-constructors)
- The `get_counter()` function should only be able to read the state of the contract and not modify it, you can read more about it in [Chapter 12.3.2 - View functions](https://book.cairo-lang.org/ch99-01-03-02-contract-functions.html#view-functions).

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

```
$ scarb test
```

### Hints

- The `increase_counter()` function should be able to modify the state of the contract (also called external function) and update the `counter` value in the `Storage`. You can read more about it in [Chapter 12.3.2 - External Functions](https://book.cairo-lang.org/ch99-01-03-02-contract-functions.html#external-functions).

## Step 3

Checkout the `step3` branch to enable the verification tests for this section.

```bash
$ git checkout -b step3 origin/step3
```

If you fell behind, the file `prev_solution.cairo` contains the solution to the previous step.

### Goal

In this step, you will need to do the following:

- import the KillSwitch interface in your project;
- store a variable named `kill_switch` as type `IKillSwitchDispatcher` in the `Storage`;
- update the constructor function, by initializing the `kill_switch` variable with a given input value

> **Note:** Analyze the `KillSwitch` code to understand the interface and the contract structure from [here](https://github.com/starknet-edu/kill-switch/blob/master/src/lib.cairo). This is already added as a dependency in your `Scarb.toml` file.

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```
$ scarb test
```

### Hints

- You need to import `Dispatcher` and `DispatcherTrait` of the KillSwitch contract. These dispatchers are automatically created and exported by the compiler. More information about Contract Dispatcher can be found in [Chapter 12.5.2 - Contract Dispatcher](https://book.cairo-lang.org/ch99-02-02-contract-dispatcher-library-dispatcher-and-system-calls.html#contract-dispatcher).
- In the constructor, you can update the variable `kill_switch` and pass the input value for the `IKillSwitchDispatcher` type. Note that the input value should be a `ContractAddress` type.

## Step 4

Checkout the `step4` branch to enable the verification tests for this section.

```bash
$ git checkout -b step4 origin/step4
```

If you fell behind, the file `prev_solution.cairo` contains the solution to the previous step.

### Goal

Implement the KillSwitch in the `increase_counter()`.

### Requirements

- If the function `is_active()` from the KillSwitch contract returns `true`, then allow the `increase_counter()` to increment the value;
- If the function `is_active()` from the KillSwitch contract returns `false`, then return without incrementing the value;

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```
$ scarb test
```

### Hints

- You can access the `is_active()` function from your `kill_switch` variable. Use this to create the logic in the `increase_counter()` function.

> **Note:** If you want to deploy the `Counter` contract, you can use the following deployed `KillSwitch` contract address.
>
> **Goerli**
>
> Contract Address: `0x033b2c899fd8f89e3e1d5b69c4d495f1018a1dbb8c19b18795c2e16b078da34d`
>
> - [Voyager](https://goerli.voyager.online/contract/0x033b2c899fd8f89e3e1d5b69c4d495f1018a1dbb8c19b18795c2e16b078da34d)
> - [Starkscan](https://testnet.starkscan.co/contract/0x033b2c899fd8f89e3e1d5b69c4d495f1018a1dbb8c19b18795c2e16b078da34d)

## Step 5

Checkout the `step5` branch to enable the verification tests for this section.

```bash
$ git checkout -b step5 origin/step5
```

If you fell behind, the file `prev_solution.cairo` contains the solution to the previous step.

### Goal

Implement an event called

- implement an event named `CounterIncreased` which emits the current value of the `counter`
- emit this event when the `counter` variable has been incremented

### Verification

When completed, execute the test suite to verify you've met all the requirements for this section.

```
$ scarb test
```

### Hints

- Events are custom data structures that are emitted by a contract. More information about Events can be found in [Chapter 12.3.3 - Contract Events](https://book.cairo-lang.org/ch99-01-03-03-contract-events.html).

## Step 6 (Final)

Checkout the `step6` branch to enable the verification tests for this section.

```bash
$ git checkout -b step6 origin/step6
```

If you fell behind, the file `prev_solution.cairo` contains the solution to the previous step.

### Goal

Check that you have correctly created an account contract for Starknet by running the full test suite:

```
$ scarb test
```

If the test suite passes, congratulations, you have created your first Counter Smart Contract on Starknet.
