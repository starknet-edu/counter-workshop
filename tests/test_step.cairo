use super::utils::deploy_contract;
use workshop::counter::{ICounterDispatcher, ICounterDispatcherTrait};

#[test]
fn increase_counter() {
    let initial_counter = 15;
    let contract_address = deploy_contract(initial_counter);
    let dispatcher = ICounterDispatcher { contract_address };

    dispatcher.increase_counter();
    let stored_counter = dispatcher.get_counter();
    assert!(stored_counter == initial_counter + 1, "Stored value not equal");
}
