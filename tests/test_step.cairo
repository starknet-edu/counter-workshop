use super::utils::deploy_contract;
use workshop::counter::{ICounterDispatcher, ICounterDispatcherTrait};

#[test]
fn check_stored_counter() {
    let initial_counter = 12;
    let contract_address = deploy_contract(initial_counter);
    let dispatcher = ICounterDispatcher { contract_address };
    let stored_counter = dispatcher.get_counter();
    assert!(stored_counter == initial_counter, "Stored value not equal");
}