use core::result::ResultTrait;
use starknet::{ContractAddress};
use snforge_std::{declare, cheatcodes::contract_class::ContractClassTrait};

pub fn deploy_contract(kill_switch: bool) -> ContractAddress {
    let contract = declare("KillSwitch").unwrap();
    let constructor_args = array![kill_switch.into()];
    let (contract_address, _ ) = contract.deploy(@constructor_args).unwrap();
    contract_address
}
