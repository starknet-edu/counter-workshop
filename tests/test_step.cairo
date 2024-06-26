use super::utils::{deploy_contract};
use openzeppelin::utils::selectors::grant_role;

#[test]
fn test_counter_contract_with_open_zeppelin() {
    assert!(grant_role == selector!("grant_role"), "Stored value not equal");
}