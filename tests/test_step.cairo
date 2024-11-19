use super::utils::{deploy_contract};
use openzeppelin_access::ownable::ownable::OwnableComponent::Errors::NOT_OWNER;

#[test]
fn test_counter_contract_with_open_zeppelin() {
    assert!(NOT_OWNER == 'Caller is not the owner', "Stored value not equal");
}