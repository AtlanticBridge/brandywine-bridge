#![no_std]

imports!();

// The holding contract on the Elrond chain, funds are sent here
// while validation of a cross chain transaction takes place
#[elrond_wasm_derive::contract(HoldingImpl)]
pub trait Holding {

	#[storage_set("owner")]
	fn set_owner(&self, address: &Address);

	#[view]
	#[storage_get("owner")]
	fn get_owner(&self) -> Address;

	#[event("0x0000000000000000000000000000000000000000000000000000000000000001")]
	fn deposit_event(&self, #[indexed] to: &Address, data: &BigUint);

	#[payable]
	#[endpoint]
	fn deposit (&self, _address: &Address, _amount: &BigUint) {
		self.deposit_event(&self.get_caller(), _amount);
		self.set_value(_address, _amount);
	}

	#[storage_set("deposit")]
    fn set_value(&self, address: &Address, value: &SerializableType);

	#[view]
	#[storage_get("deposit")]
	fn get_deposit(&self, address: &Address) -> SerializableType;

	#[init]
	fn init(&self) {
		let deployer_address: Address = self.get_caller();
		self.set_owner(&deployer_address);
	}


}
