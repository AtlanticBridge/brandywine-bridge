use egld_holding::*;
use elrond_wasm_debug::*;

fn main() {
	let contract = HoldingImpl::new(TxContext::dummy());
	print!("{}", abi_json::contract_abi(&contract));
}
