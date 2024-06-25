use super::utils::{deploy_contract};
use workshop::counter::{ICounterDispatcher, ICounterDispatcherTrait};
use snforge_std::{declare, cheatcodes::contract_class::ContractClassTrait};
use kill_switch::{IKillSwitchDispatcher, IKillSwitchDispatcherTrait};

#[test]
fn test_counter_contract_with_kill_switch_deactivated() {
    let initial_counter = 15;
    let contract_address = deploy_contract(initial_counter, false);
    let dispatcher = ICounterDispatcher { contract_address };

    dispatcher.increase_counter();
    let stored_counter = dispatcher.get_counter();
    assert!(stored_counter == initial_counter + 1, "Value not increased");
}

#[test]
#[should_panic(expected: ("Value not increased",))]
fn test_counter_contract_with_kill_switch_activated() {
    let initial_counter = 15;
    let contract_address = deploy_contract(initial_counter, true);
    let dispatcher = ICounterDispatcher { contract_address };

    dispatcher.increase_counter();
    let stored_counter = dispatcher.get_counter();
    assert!(stored_counter == initial_counter + 1, "Value not increased");
}
