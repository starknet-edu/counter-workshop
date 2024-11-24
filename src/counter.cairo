#[starknet::interface]
pub trait ICounter<T>{
    fn get_counter(self: @T) -> u32;
    fn increase_counter(ref self: T); 
}

#[starknet::contract]
pub mod counter_contract {
    use super::ICounter;
    use starknet::event::EventEmitter;
    use starknet::storage::{StoragePointerWriteAccess, StoragePointerReadAccess};

    #[storage]
    struct Storage {
        counter: u32,
    }

    #[constructor]
    fn constructor(ref self: ContractState, initial_value: u32) {
        self.counter.write(initial_value);
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event { 
        CounterIncreased: CounterIncreased,
    }

    #[derive(Drop, starknet::Event)]
    pub struct CounterIncreased {
        pub value: u32,
    }

    #[abi(embed_v0)]
    impl CounterImpl of ICounter<ContractState> {

        fn get_counter(self: @ContractState) -> u32 { 
            self.counter.read()
        }
        
        fn increase_counter(ref self: ContractState) {
            self.counter.write(self.get_counter() + 1 );
            self.emit( CounterIncreased {value: self.get_counter()});
        }
    }
}