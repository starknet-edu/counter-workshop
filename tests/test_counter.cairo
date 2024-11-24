use super::utils::{deploy_contract, Accounts};
use snforge_std::{start_cheat_caller_address, stop_cheat_caller_address};
use workshop::counter::{ICounterDispatcher, ICounterDispatcherTrait};

#[test]
fn check_increase_counter_as_owner() {
    let initial_counter = 12;
    let contract_address = deploy_contract(initial_counter);
    let dispatcher = ICounterDispatcher { contract_address };

    start_cheat_caller_address(contract_address, Accounts::OWNER());
    dispatcher.increase_counter();

    let stored_counter = dispatcher.get_counter();
    assert!(stored_counter == initial_counter + 1, "Wrong Increase Counter");
    stop_cheat_caller_address(contract_address);
}


#[test]
#[should_panic(expected: 'Caller is not the owner')]
fn check_increase_counter_as_bad_actor() {
    let initial_counter = 12;
    let contract_address = deploy_contract(initial_counter);
    let dispatcher = ICounterDispatcher { contract_address };

    start_cheat_caller_address(contract_address, Accounts::BAD_ACTOR());
    dispatcher.increase_counter();

    let stored_counter = dispatcher.get_counter();
    assert!(stored_counter == initial_counter + 1, "Wrong Increase Counter");
    stop_cheat_caller_address(contract_address);
}