use super::utils::{deploy_contract};
use counter::counter::{ICounterDispatcher, ICounterDispatcherTrait};
use snforge_std::{declare, cheatcodes::contract_class::ContractClassTrait};
use kill_switch::{IKillSwitchDispatcher, IKillSwitchDispatcherTrait};
use snforge_std::{ load, map_entry_address };

#[test]
fn test_kill_switch_contract_actived() {
    let contract = declare("KillSwitch");
    let constructor_args = array![true.into()];
    let contract_address = contract.deploy(@constructor_args).unwrap();

    let dispatcher = IKillSwitchDispatcher { contract_address };

    assert!(dispatcher.is_active(), "Kill Switch Activation failed");
}

#[test]
fn test_kill_switch_contract_deactivated() {
    let contract = declare("KillSwitch");
    let constructor_args = array![false.into()];
    let contract_address = contract.deploy(@constructor_args).unwrap();

    let dispatcher = IKillSwitchDispatcher { contract_address };

    assert!(!dispatcher.is_active(), "Kill Switch Activation failed");
}

#[test]
fn test_counter_contract() {
    let initial_value = 10;
    let (contract_address, kill_switch_address) = deploy_contract(initial_value, false);

    let dispatcher = ICounterDispatcher{contract_address};
    assert!(dispatcher.get_counter() == initial_value, "Stored value not equal");

    let loaded = load(contract_address, selector!("kill_switch"), 1);
    assert!(*loaded.at(0) == kill_switch_address.into(), "Kill Switch address not matched");
}