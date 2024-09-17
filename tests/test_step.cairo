use super::utils::deploy_contract;
use workshop::counter::{ICounterDispatcher, ICounterDispatcherTrait, counter_contract};
use snforge_std::{spy_events, EventSpy, EventSpyAssertionsTrait};

#[test]
fn test_counter_event() {
    let initial_counter = 15;
    let contract_address = deploy_contract(initial_counter);
    let dispatcher = ICounterDispatcher { contract_address };

    let mut spy = spy_events();
    dispatcher.increase_counter();

    spy.assert_emitted(@array![ 
        (
            contract_address,
            counter_contract::Event::CounterIncreased(
                counter_contract::CounterIncreased { value: 16 }
            )
        )
    ]);

}
