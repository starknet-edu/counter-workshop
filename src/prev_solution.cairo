use starknet::ContractAddress;

#[starknet::interface]
trait ICounter<TContractState> {
    fn get_counter(self: @TContractState) -> u32;
    fn increase_counter(ref self: TContractState);
}

#[starknet::contract]
mod Counter {
    use starknet::{ContractAddress};
    use super::{ICounter};
    use kill_switch::{IKillSwitchDispatcher, IKillSwitchDispatcherTrait};

    #[storage]
    struct Storage {
        counter: u32,
        kill_switch: IKillSwitchDispatcher,
    }

    #[constructor]
    fn constructor(
        ref self: ContractState, initial_counter: u32, kill_switch_address: ContractAddress
    ) {
        self.counter.write(initial_counter);
        self.kill_switch.write(IKillSwitchDispatcher { contract_address: kill_switch_address });
    }

    #[abi(embed_v0)]
    impl CounterImpl of ICounter<ContractState> {
        fn get_counter(self: @ContractState) -> u32 {
            self.counter.read()
        }
        fn increase_counter(ref self: ContractState) {
            let current_counter = self.counter.read();
            self.counter.write(current_counter + 1);
        }
    }
}
