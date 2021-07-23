// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";
import "../Utils/Math.sol";

/**
 * @dev Instructions for building the bridge.
 *
 *  1] Receives ETH
 *  2] FUNCTION: Deposit 
 *
 * INHERIT
 * -------
 *
 * [1] We inherit the ChainlinkClient contract so we can create and fulfill order requests to our Chainlink node.
 * [2] We inherit the Math contract in order to use the Math needed for converting the _minted amounts between uint256 and string.
 *
 * 
 * TODO:
 *      [1] Implement a withdraw function to retrieve the Link locked in the contract. Must 
 */
contract Bridge2Elrond is ChainlinkClient, Math {
    
    // --- LOCAL VARIABLES ---
    address private oracle = 0xFA9E7d769870CEAa202C1090D80daF7CBd655F56;        // TODO: Needs to be changed.
    bytes32 private jobId_eth2erd;
    uint256 private fee;
    uint256 public  numOracles = 20;
    bool private initialized;

    // --- FUND MANAGEMENT VARIABLES --- 
    mapping(address => uint256) private MintingAmount;
    mapping(address => address) private _OracleList;
    mapping(uint256 => BridgeResponse[]) private MapResponse;

    // --- STRUCTS ---
    struct BridgeResponse {
        uint256 _num;
        uint256 _minted;
    }

    // --- EVENTS ---
    event Success(address indexed _from, bytes32 indexed _id, bool _success, uint256 _value);

    // Map to 
    
    /**
     * Network: Kovan
     * Oracle: 0xFA9E7d769870CEAa202C1090D80daF7CBd655F56
     * Job ID Average: 58ae9ae2e43a45219185bec59b3794eb
     * Job ID Highlow: 740306a4d92d4ab1ad07f033183a5975
     * Fee: 1.1 LINK
     */
    function initialize(uint256 _fee) public {

        require(!initialized, "Contract instance has already been initialized");
        initialized = true;

        setPublicChainlinkToken();
        oracle = 0xFA9E7d769870CEAa202C1090D80daF7CBd655F56;        // Add your node oracle here.

        // Setup the initial list of Job Specifications.
        jobId_eth2erd = "ENTER_NUMBER_HERE";                        // Add the jobID of your chainlink external adapter job here.
        fee = _fee;                                                 // (Varies by network and job)

    }


    /**
     * requestElrondTransfer()
     *
     *           This function builds a Chainlink request to retrive the high or
     *           low address within the pre-defined URL. No URL is needed to pass
     *           as it is already hard coded in the EA. 
     *            
     * 
     * Parameters
     * ----------
     * _highlow : string
     *          - The 'high' or 'low' parameter to query the "highlow" EA response.
     *
     */
    function requestElrondTransfer(string memory elrondAddress) minimumAmount public payable
    {
        // NOTE: [1] Do we need any requirements?
        // NOTE: [2] What if a user/address sends multiple requests?
        // NOTE: [3] Do we need a NONCE to keep track of transaction requests from the user?
    
        // TODO:
        //      [1] What if a user/address sends multiple requests?
        //      

        // Sets the amount minted to the 
        MintingAmount[msg.sender] = msg.value;

        // Converts the paid amount into a string
        string memory strAmount = uint2str(msg.value);

        // Builds the Chainlink Request
        Chainlink.Request memory request = buildChainlinkRequest(jobId_eth2erd, address(this), this.fulfillElrondTransfer.selector);
        
        // Set the Endpoint with the parameter for the amount of WEI
        request.add("transfer", strAmount);

        request.add("elrond", elrondAddress);
        
        // Sends the request
        sendChainlinkRequestTo(oracle, request, fee);
    }
    

    /**
     * fulfillElrondTransfer()
     *
     *           Receives the fulfillElrondTransfer() response in the form of bytes32.
     *            
     * 
     * Parameters
     * ----------
     * _requestId : bytes32
     *            - The Chainlink Request, request ID, sent with the payload.
     *
     * _strMinted : bytes32
     *            - The "high" or "low" address returned from the pre-defined endpoint.
     *
     *
     *      NOTE: [1] How do we figure out what gas price is going to be paid?
     *      NOTE: [2] We might want to include another function for a user to send more ETH to the contract in order to actually fulfill their payout?
     *      NOTE: [3] Is the [A] msg.sender still the same on the return fulfillment transfer or [B] will it be the Oracle contract address?
     *
     *      TODO: 
     *            [1] Create a function to return the funds to the transfer requester if the bridge is not successful. 
     *
     */
    function fulfillElrondTransfer(bytes32 _requestId, bytes32 _strMinted) public recordChainlinkFulfillment(_requestId)
    {
        /*
        We want to aggregate the responses and double check whether the results were correct or not.

        The 
        */
        uint256 _minted = asciiToInteger(_strMinted);

        // We want to check and make sure that the amount minted is the correct amount and no additional values where 
        // Calculate Balance:
        //      - We need to calculate the balance from the original 
        uint256 _balance = address(this).balance;

        if(_balance != _minted) {
            emit Success(msg.sender, _requestId, true, _minted);    // Contract was successfully filled.
        }

        emit Success(msg.sender, _requestId, false, _minted);       // Contract did not successfully fill.
                                                                    // TODO: We want to "cancel" the order and return funds to user.
    }
 
    // function withdrawLink() external {} - Implement a withdraw function to avoid locking your LINK in the contract

    // *****************
    // --- MODIFIERS ---
    // *****************
    modifier minimumAmount {
        require(msg.value > 100000);
        _;
    }
}