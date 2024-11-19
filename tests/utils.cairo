use starknet::{ContractAddress};
use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};

pub mod Accounts {
    use starknet::{ContractAddress};
    use starknet::contract_address_const;

    pub fn OWNER() -> ContractAddress {
        contract_address_const::<'owner'>()
    }

    pub fn NEW_OWNER() -> ContractAddress {
        contract_address_const::<'new_owner'>()
    }

    pub fn BAD_ACTOR() -> ContractAddress {
        contract_address_const::<'bad_actor'>()
    }
    
    pub fn ZERO() -> ContractAddress {
        contract_address_const::<0>()
    }
}


pub fn deploy_contract(initial_value: u32, kill_switch: bool) -> ContractAddress {
    let contract = declare("KillSwitch").unwrap().contract_class();
    let constructor_args = array![kill_switch.into()];
    let (contract_address, _) = contract.deploy(@constructor_args).unwrap();

    let contract = declare("counter_contract").unwrap().contract_class();
    let constructor_args = array![initial_value.into(), contract_address.into()];
    let (contract_address, _) = contract.deploy(@constructor_args).unwrap();
    contract_address
}