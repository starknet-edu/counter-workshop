#[derive(starknet::Event, Drop)]
#[starknet::interface]
trait ICounter<TContractState> {
    fn get_counter(self: @TContractState) -> u32;
    fn increase_counter(ref self: TContractState);
}

#[starknet::contract]
pub mod counter_contract {
    use starknet::event::EventEmitter;

    #[storage]
    struct Storage {
        counter: u32,
    }

    #[constructor]
    fn constructor(ref self: ContractState, initial_value: u32) {
        self.counter.write(initial_value);
    }

    #[event]
    #[derive(starknet::Event, Drop)]
    enum Event {
        CounterIncreased: CounterIncreased,
    }

    #[derive(starknet::Event, Drop)]
    struct CounterIncreased {
        value: u32
    }

    #[external(v0)]
    fn get_counter(ref self: ContractState) -> u32 {
        self.counter.read()
    }
    
    #[external(v0)]
    fn increase_counter(ref self: ContractState) {
        self.counter.write(self.counter.read() + 1);
        self.emit(CounterIncreased { value: self.counter.read() });
    }
}


// - Define a variant named `CounterIncreased` in the `Event` enum.
// - Defining the `value` variable within the `CounterIncrease` struct.
// - Emit the event in the `increase_counter()` function with the new value, once the `counter` value has been incremented.
