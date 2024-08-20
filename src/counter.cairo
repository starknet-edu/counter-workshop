
#[starknet::interface]
pub trait ICounter<TContractState> {
    fn get_counter(self: @TContractState) -> u32;
    fn increase_counter(ref self: TContractState) -> ();
}

#[starknet::contract]
pub mod counter_contract {
    use core::starknet::event::EventEmitter;
    use starknet::ContractAddress;
    use kill_switch::{IKillSwitchDispatcher,IKillSwitchDispatcherTrait};
    use openzeppelin::access::ownable::OwnableComponent;
   
    component!(path: OwnableComponent, storage: ownable, event: OwnableEvent);
    // Ownable Mixin
    #[abi(embed_v0)]
    impl OwnableMixinImpl = OwnableComponent::OwnableMixinImpl<ContractState>;
    impl InternalImpl = OwnableComponent::InternalImpl<ContractState>;

    #[storage]
    struct Storage {
        counter: u32,
        kill_switch_contract_address: ContractAddress,
        #[substorage(v0)]
        ownable: OwnableComponent::Storage
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        CounterIncreased: CounterIncreased,
        #[flat]
        OwnableEvent: OwnableComponent::Event
    }

    #[derive(Drop, starknet::Event)]
    struct CounterIncreased {
        #[key]
        counter: u32, 
    }

    #[constructor]
    pub fn constructor(ref self: ContractState, counter: u32) {
        self.counter.write(counter);
        // self.kill_switch_contract_address.write(kill_switch_address);
    }
    #[abi(embed_v0)]
    impl IcounterImpl of super::ICounter<ContractState>{
        fn get_counter(self: @ContractState) -> u32{
            let value = self.counter.read();
            value
        }
        
        fn increase_counter(ref self: ContractState) -> (){
            let value = self.counter.read();
            let kill_switch_address = self.kill_switch_contract_address.read();
            let is_active = IKillSwitchDispatcher{contract_address: kill_switch_address}.is_active();
            assert!(!is_active,"Kill Switch is active");
            self.counter.write(value + 1);
            self.emit(CounterIncreased{counter: value + 1});
           
        }
    }
}