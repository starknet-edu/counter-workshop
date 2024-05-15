use starknet::{ContractAddress, Into, TryInto};
use snforge_std::{declare, cheatcodes::contract_class::ContractClassTrait};


fn deploy_contract(initial_value: u32) -> ContractAddress {
    let contract = declare("Counter").unwrap();
    let constructor_args = array![initial_value.into()];
    let (contract_address, _ ) = contract.deploy(@constructor_args).unwrap();
    return contract_address;
}