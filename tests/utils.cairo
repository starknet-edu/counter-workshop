use starknet::{ContractAddress};
use snforge_std::{declare, cheatcodes::contract_class::ContractClassTrait};

mod Errors {
    const NOT_EQUAL: felt252 = 'Stored value not equal';
    const NOT_INCREASED: felt252 = 'Value not increased';
}

fn deploy_contract(kill_switch: bool) -> ContractAddress {
    let contract = declare("KillSwitch");
    let constructor_args = array![kill_switch.into()];
    contract.deploy(@constructor_args).unwrap()
}