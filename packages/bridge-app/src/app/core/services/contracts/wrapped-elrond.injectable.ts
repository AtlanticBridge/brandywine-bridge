import { Inject, Injectable } from "@angular/core";
import { Contract, ethers, providers } from "ethers";

// --- IMPORT CONTRACT ABI DATA ---
import * as ContractJson from "../../../contracts/ElrondEth/ElrondEth.json";
import { MetaMaskProvider } from "../../injectables/etheres.injectable";

@Injectable({ providedIn: 'root' })
export class WrappedElrondInjectable extends Contract {

    constructor(
        @Inject(MetaMaskProvider) _provider: providers.Web3Provider
    ) {
        // --- Contract Address ---
        let wrappedElrondAddress = "";

        // --- MetaMask Signer ---
        let signer = _provider.getSigner()

        // --- Ethers contract Class Initialized parameters ---
        super(wrappedElrondAddress, ContractJson.abi, signer)
    }
}