#[starknet::interface]
trait ICounter<TContractState> {
    fn get_counter(self: @TContractState) -> u32;
    fn increase_counter(ref self: TContractState);
}

#[starknet::contract]
pub mod counter_contract {
    #[storage]
    struct Storage {
        counter: u32,
    }

    #[constructor]
    fn constructor(ref self: ContractState, initial_value: u32) {
        self.counter.write(initial_value);
    }

    #[external(v0)]
    fn get_counter(ref self: ContractState) -> u32 {
        self.counter.read()
    }
    
    #[external(v0)]
    fn increase_counter(ref self: ContractState) {
        self.counter.write(self.counter.read() + 1);
    }
}
