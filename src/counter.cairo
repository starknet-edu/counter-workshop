#[starknet::contract]
pub mod counter_contract {
    #[storage]
    struct Storage {
        counter: u32,
    }

    #[constructor]
    fn constructor(ref self: ContractState, initial_value: u32
    ) {
        self.counter.write(initial_value);
    }
}



// - Store a variable named `counter` as `u32` type in the `Storage` struct.
// - Implement the constructor function that initializes the `counter` variable with a given input value.
// - The input variable of the constructor function should be named `initial_value`