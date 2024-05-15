use starknet::{ContractAddress};
use snforge_std::{declare, cheatcodes::contract_class::ContractClassTrait};

mod Accounts {
    use traits::TryInto;
    use starknet::{ContractAddress};
    use starknet::contract_address_const;

    fn OWNER() -> ContractAddress {
        contract_address_const::<'owner'>()
    }

    fn NEW_OWNER() -> ContractAddress {
        contract_address_const::<'new_owner'>()
    }

    fn BAD_ACTOR() -> ContractAddress {
        contract_address_const::<'bad_actor'>()
    }
    fn ZERO() -> ContractAddress {
        contract_address_const::<0>()
    }
}


fn deploy_contract(initial_value: u32, kill_switch: bool) -> ContractAddress {
    let contract = declare("KillSwitch").unwrap();
    let constructor_args = array![kill_switch.into()];
    let (contract_address, _) = contract.deploy(@constructor_args).unwrap();

    let contract = declare("Counter").unwrap();
    let constructor_args: Array<felt252> = array![
        initial_value.into(), contract_address.into(), Accounts::OWNER().into()
    ];
    let (contract_address, _) = contract.deploy(@constructor_args).unwrap();
    return contract_address;

}