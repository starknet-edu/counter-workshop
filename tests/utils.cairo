use starknet::{ContractAddress};
use snforge_std::{declare, cheatcodes::contract_class::ContractClassTrait};

pub fn deploy_contract(
    initial_value: u32, kill_switch: bool
) -> (ContractAddress, ContractAddress) {
    let contract = declare("KillSwitch").unwrap();
    let constructor_args = array![kill_switch.into()];
    let (contract_address, _) = contract.deploy(@constructor_args).unwrap();

    let contract = declare("counter_contract").unwrap();
    let constructor_args = array![initial_value.into(), contract_address.into()];
    let (counter_address, _) = contract.deploy(@constructor_args).unwrap();
    return (counter_address, contract_address);
}
