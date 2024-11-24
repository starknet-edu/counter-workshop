#[starknet::interface]
pub trait ICounter<T>{
    fn get_counter(self: @T) -> u32;
    fn increase_counter(ref self: T); 
}

#[starknet::contract] 
pub mod counter_contract {
    use OwnableComponent::InternalTrait;
    use super::ICounter;
    use starknet::event::EventEmitter;
    use starknet::storage::{StoragePointerWriteAccess, StoragePointerReadAccess};
    use starknet::{ContractAddress};
    use openzeppelin_access::ownable::OwnableComponent;
    use kill_switch::{IKillSwitchDispatcher, IKillSwitchDispatcherTrait};

    component!(path: OwnableComponent, storage: ownable, event: OwnableEvent);

    #[abi(embed_v0)]
    impl OwnableImpl = OwnableComponent::OwnableImpl<ContractState>;
    impl OwnableInternalImpl = OwnableComponent::InternalImpl<ContractState>;

    #[storage]
    struct Storage {
        counter: u32,
        kill_switch: ContractAddress,
        #[substorage(v0)]
        ownable: OwnableComponent::Storage
    }


    #[constructor]
    fn constructor(ref self: ContractState, initial_value: u32, kill_switch: ContractAddress, initial_owner: ContractAddress) {
        self.counter.write(initial_value);
        self.kill_switch.write(kill_switch);
        self.ownable.initializer(initial_owner);
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event { 
        CounterIncreased: CounterIncreased,
        OwnableEvent: OwnableComponent::Event
    }

    #[derive(Drop, starknet::Event)]
    pub struct CounterIncreased {
        pub value: u32,
    }

    #[abi(embed_v0)] 
    impl CounterImpl of ICounter<ContractState>{
        fn get_counter(self: @ContractState) -> u32 { 
            self.counter.read()
        }
        
        fn increase_counter(ref self: ContractState) {
            self.ownable.assert_only_owner();
            let dispatcher = IKillSwitchDispatcher {contract_address: self.kill_switch.read()};
            assert!(!dispatcher.is_active(), "Kill Switch is active");
   
            self.counter.write(self.get_counter() + 1 );
            self.emit( CounterIncreased {value: self.get_counter()});
     
        }
    }
}