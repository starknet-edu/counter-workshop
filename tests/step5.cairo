use super::utils::{deploy_contract, Errors};
use counter::counter::{ICounterDispatcher, ICounterDispatcherTrait};
use kill_switch::{IKillSwitchDispatcher, IKillSwitchDispatcherTrait};
use snforge_std::{
    spy_events, EventSpy, EventFetcher, event_name_hash, EventAssertions, Event, SpyOn
};

#[test]
fn test_counter_event() {
    let initial_counter = 15;
    let contract_address = deploy_contract(initial_counter, true);
    let dispatcher = ICounterDispatcher { contract_address };

    let mut spy = spy_events(SpyOn::One(contract_address));
    dispatcher.increase_counter();

    spy.fetch_events();
    assert(spy.events.len() == 1, 'There should be one event');

    let (from, event) = spy.events.at(0);
    assert(from == @contract_address, 'Emitted from wrong address');

    assert(event.keys.len() == 1, 'There should be one key');

    assert(event.keys.at(0) == @event_name_hash('CounterIncreased'), 'Wrong event name');

    assert(event.data.len() == 1, 'There should be one data');
}
