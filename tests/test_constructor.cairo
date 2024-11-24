use starknet::{ContractAddress, contract_address_const};
use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};
use workshop::counter::{ICounterDispatcher, ICounterDispatcherTrait};

#[test]
fn test_construction_function() {
    // create constructor arguments
    let initial_value: u32 = 32;
    let owner: ContractAddress = contract_address_const::<'owner'>();

    // deploy contract
    let contract = declare("counter_contract").unwrap().contract_class();
    let constructor_args: Array<felt252> = array![initial_value.into(), owner.into()];
    let (contract_address, _) = contract.deploy(@constructor_args).unwrap();

    // verify value
    let dispatcher = ICounterDispatcher { contract_address };

    let current_counter = dispatcher.get_counter();

    println!("Current counter value is {}", current_counter);

    assert!(current_counter == 32, "Construction function initialisation has failed!");

}