use super::utils::{deploy_contract, Errors, Accounts};
use openzeppelin::access::ownable::interface::{IOwnableDispatcher, IOwnableDispatcherTrait};
use snforge_std::{start_prank, stop_prank, CheatTarget};

#[test]
#[should_panic(expected: ('Caller is not the owner',))]
fn check_renounce_ownership_as_bad_actor() {
    let initial_counter = 0;
    let contract_address = deploy_contract(initial_counter, true);
    let dispatcher = IOwnableDispatcher { contract_address };

    start_prank(CheatTarget::One(contract_address), Accounts::BAD_ACTOR());
    dispatcher.renounce_ownership();
    let current_owner = dispatcher.owner();
    assert!(current_owner == Accounts::ZERO(), "Owner not renounced");
    stop_prank(CheatTarget::One(contract_address));
}

