#![no_std]

imports!();

/// One of the simplest smart contracts possible,
/// it holds a single variable in storage, which anyone can increment.
#[elrond_wasm_derive::contract(EthElrondImpl)]
pub trait EthElrond {

	#[storage_set("owner")]
	fn set_owner(&self, address: &Address);

	#[view]
	#[storage_get("owner")]
	fn get_owner(&self) -> Address;

	#[endpoint]
	#[storage_set("fee")]
	fn set_fee(&self, fee: &BigUint);

	#[view]
	#[storage_get("fee")]
	fn get_fee(&self) -> BigUint;

	#[event("0x0000000000000000000000000000000000000000000000000000000000000001")]
	fn mint_event(&self, #[indexed] to: &Address, data: &BigUint);

	#[payable]
	#[endpoint]
	fn deposit (&self, _amount: &BigUint) {
		self.mint_event(&self.get_caller(), _amount)
	}

	#[init]
	fn init(&self, fee: &BigUint) {
		let deployer_address: Address = self.get_caller();
		self.set_owner(&deployer_address);
		self.set_fee(fee)
	}

}
