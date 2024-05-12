use super::utils::{deploy_contract, Accounts};
use openzeppelin::access::ownable::interface::{IOwnableDispatcher, IOwnableDispatcherTrait};
use snforge_std::{start_prank, stop_prank, CheatTarget};
use counter::counter::{ICounterDispatcher, ICounterDispatcherTrait};

#[test]
fn check_constructor_initial_owner() {
    let initial_counter = 12;
    let contract_address = deploy_contract(initial_counter, false);
    let dispatcher = IOwnableDispatcher { contract_address };
    let current_owner = dispatcher.owner();
    assert!(Accounts::OWNER() == current_owner, "Not the owner");
}

#[test]
fn check_transfer_ownership_as_owner() {
    let initial_counter = 0;
    let contract_address = deploy_contract(initial_counter, false);
    let dispatcher = IOwnableDispatcher { contract_address };

    start_prank(CheatTarget::One(contract_address), Accounts::OWNER());
    dispatcher.transfer_ownership(Accounts::NEW_OWNER());
    let current_owner = dispatcher.owner();
    assert!(current_owner == Accounts::NEW_OWNER(), "Owner not changed");
    stop_prank(CheatTarget::One(contract_address));
}

#[test]
#[should_panic(expected: ('New owner is the zero address',))]
fn check_transfer_ownership_to_zero_address() {
    let initial_counter = 0;
    let contract_address = deploy_contract(initial_counter, false);
    let dispatcher = IOwnableDispatcher { contract_address };

    start_prank(CheatTarget::One(contract_address), Accounts::OWNER());
    dispatcher.transfer_ownership(Accounts::ZERO());
    let current_owner = dispatcher.owner();
    assert!(current_owner == Accounts::NEW_OWNER(), "Owner not changed");
    stop_prank(CheatTarget::One(contract_address));
}

#[test]
fn check_increase_counter_as_owner() {
    let initial_counter = 12;
    let contract_address = deploy_contract(initial_counter, false);
    let dispatcher = ICounterDispatcher { contract_address };

    start_prank(CheatTarget::One(contract_address), Accounts::OWNER());
    dispatcher.increase_counter();

    let stored_counter = dispatcher.get_counter();
    assert!(stored_counter == initial_counter + 1, "Wrong Increase Counter");
    stop_prank(CheatTarget::One(contract_address));
}

#[test]
#[should_panic(expected: ('Caller is not the owner',))]
fn check_increase_counter_as_bad_actor() {
    let initial_counter = 12;
    let contract_address = deploy_contract(initial_counter, false);
    let dispatcher = ICounterDispatcher { contract_address };

    start_prank(CheatTarget::One(contract_address), Accounts::BAD_ACTOR());
    dispatcher.increase_counter();

    let stored_counter = dispatcher.get_counter();
    assert!(stored_counter == initial_counter + 1, "Wrong Increase Counter");
    stop_prank(CheatTarget::One(contract_address));
}

#[test]
#[should_panic(expected: ("Kill Switch is active",))]
fn check_increase_counter_as_owner_with_kill_switch() {
    let initial_counter = 12;
    let contract_address = deploy_contract(initial_counter, true);
    let dispatcher = ICounterDispatcher { contract_address };

    start_prank(CheatTarget::One(contract_address), Accounts::OWNER());
    dispatcher.increase_counter();

    let stored_counter = dispatcher.get_counter();
    assert!(stored_counter == initial_counter + 1, "Wrong Increase Counter");
    stop_prank(CheatTarget::One(contract_address));
}
