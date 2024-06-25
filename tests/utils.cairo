use starknet::{ContractAddress};
use snforge_std::{declare, cheatcodes::contract_class::ContractClassTrait};

pub fn deploy_contract(initial_value: u32) -> ContractAddress {
    let contract = declare("counter_contract").unwrap();
    let constructor_args = array![initial_value.into()];
    let (contract_adress, _) = contract.deploy(@constructor_args).unwrap();
    contract_adress
}
