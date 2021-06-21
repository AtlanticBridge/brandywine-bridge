import { ethers, providers } from "ethers";

class ProviderConnect {

    RpcProvider: any;

    constructor() { }

    connectRpc(url:string) {
        this.RpcProvider = new providers.JsonRpcProvider(url);
    }
}