use starknet::{ContractAddress};
use snforge_std::{declare, cheatcodes::contract_class::ContractClassTrait};

mod Errors {
    const NOT_EQUAL: felt252 = 'Stored value not equal';
}

fn deploy_contract(initial_value: u32) -> ContractAddress {
    let contract = declare("Counter");
    let constructor_args = array![initial_value.into()];
    return contract.deploy(@constructor_args).unwrap();
}