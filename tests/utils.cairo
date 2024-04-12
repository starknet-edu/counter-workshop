use starknet::{ContractAddress};
use snforge_std::{declare, cheatcodes::contract_class::ContractClassTrait};

mod Errors {
    const NOT_EQUAL: felt252 = 'Stored value not equal';
    const NOT_INCREASED: felt252 = 'Value not increased';
    const NOT_OWNER: felt252 = 'Not the owner';
}

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
    let contract = declare("KillSwitch");
    let constructor_args = array![kill_switch.into()];
    let contract_address = contract.deploy(@constructor_args).unwrap();

    let contract = declare("Counter");
    let constructor_args: Array<felt252> = array![
        initial_value.into(), contract_address.into(), Accounts::OWNER().into()
    ];
    contract.deploy(@constructor_args).unwrap()

}