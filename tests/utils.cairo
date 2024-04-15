use starknet::{ContractAddress};
use snforge_std::{declare, cheatcodes::contract_class::ContractClassTrait};

fn deploy_contract(initial_value: u32, kill_switch: bool) -> ContractAddress {
    let contract = declare("KillSwitch");
    let constructor_args = array![kill_switch.into()];
    let contract_address = contract.deploy(@constructor_args).unwrap();

    let contract = declare("Counter");
    let constructor_args = array![initial_value.into(), contract_address.into()];
    return contract.deploy(@constructor_args).unwrap();
}