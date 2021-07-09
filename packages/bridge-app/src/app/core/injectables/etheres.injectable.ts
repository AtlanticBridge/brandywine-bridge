import { InjectionToken } from "@angular/core";
import WalletConnectProvider from "@walletconnect/web3-provider";
import { ethers, providers } from "ethers";
import { environment } from "../../../environments/environment";


const MetaMaskProvider = new InjectionToken<providers.Web3Provider>('MetaMask Connected', {
    providedIn: 'root',
    factory: () => {
        const ethersProvider = new ethers.providers.Web3Provider((window as any).ethereum);
        return ethersProvider
    }
})

const RpcProvider = new InjectionToken<providers.JsonRpcProvider>('HardHat Ethereum RPC Provider', {
    providedIn: 'root',
    factory: () => new providers.JsonRpcProvider(environment.RPC_PROVIDER_URL)
})

// const KovanWebSocketProvider = new InjectionToken<providers.WebSocketProvider>('Truffle Ethereum RPC Provider', {
//     providedIn: 'root',
//     factory: () => new providers.WebSocketProvider(environment.KOVAN_WSS_URL)
// })

const walletConnectProvider = new InjectionToken<providers.Web3Provider>('Wallet Connect Provider', {
    providedIn: 'root',
    factory: () => {
        const wcProvider = new WalletConnectProvider({
            infuraId: "my-infura-id",        // required
            qrcode: true
        });
        // await wcProvider.enable();
        return new providers.Web3Provider(wcProvider)
    }
})

// const walletConnectProvider = new WalletConnectProvider({})

export { MetaMaskProvider, walletConnectProvider, RpcProvider }