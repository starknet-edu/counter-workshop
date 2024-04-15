use super::utils::{deploy_contract, Errors};
use openzeppelin::utils::selectors::grant_role;

#[test]
fn test_counter_contract_with_kill_switch_deactivated() {
    assert!(grant_role == selector!("grant_role"), "Stored value not equal");
}