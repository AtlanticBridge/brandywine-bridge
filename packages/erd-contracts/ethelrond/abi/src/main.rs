use ethelrond::*;
use elrond_wasm_debug::*;

fn main() {
	let contract = EthElrondImpl::new(TxContext::dummy());
	print!("{}", abi_json::contract_abi(&contract));
}
