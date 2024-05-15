use starknet::{ContractAddress};
use snforge_std::{declare, cheatcodes::contract_class::ContractClassTrait};

fn deploy_contract(initial_value: u32, kill_switch: bool) -> (ContractAddress, ContractAddress) {
    let contract = declare("KillSwitch").unwrap();
    let constructor_args = array![kill_switch.into()];
    let (kill_switch_contract_address, _) = contract.deploy(@constructor_args).unwrap();

    let contract = declare("Counter").unwrap();
    let constructor_args = array![initial_value.into(), kill_switch_contract_address.into()];
    let (contract_address, _) = contract.deploy(@constructor_args).unwrap();
    return (contract_address, kill_switch_contract_address);
}