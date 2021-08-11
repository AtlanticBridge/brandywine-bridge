// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";
import "../Utils/Math.sol";
import "../Bridge/Bridge.sol";

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
contract ChainlinkRequest is ChainlinkClient, AccessControl {

    using BridgeRoles for bytes32;
    Bridge bdg;
    
    // --- LOCAL VARIABLES ---
    bool private initialized = false;
    address private bridgeAddress; 
    uint256 private fee;                

    // --- FUND MANAGEMENT VARIABLES --- 
    mapping(address => uint256) private MintingAmount;

    // --- EVENTS ---
    event Success(address indexed _from, bytes32 indexed _id, bool _success, uint256 _value);

    
    /**
     * initialize()
     *
     *
     * DESCRIPTION
     * -----------
     * The initialization function when deploying new updates to the contract.
     *
     *
     * PARAMETERS
     * ----------
     * _fee : uint256
     *      - The Chainlink fee to be paid out to the Oracle node.
     *
     * _bridgeAddress : address
     *      - The receiving address for minted tokens.
     *
     */
    function initialize(
        uint256 _fee,
        address _bridgeAddress
    ) public {

        require(!initialized, "Contract instance has already been initialized");
        initialized = true;

        setPublicChainlinkToken();

        // NOTE: The bridge address MUST set this address as a authorized accessor in
        //       order for this contract to use methods (functions) on the Bridge
        //       contract.
        bridgeAddress = _bridgeAddress;
        fee = _fee;

        // Link to External Contracts
        bdg = Bridge(_bridgeAddress);

    }


    /**
     * requestTokenTransfer()
     *
     *           This function builds a Chainlink request to retrive the high or
     *           low address within the pre-defined URL. No URL is needed to pass
     *           as it is already hard coded in the EA. 
     *            
     * 
     * Parameters
     * ----------
     * rcvAddress : string
     *          - The recieving address that the minted tokens will be sent to.
     *
     */
    function requestTokenTransfer(
        string memory rcvAddress
    ) minimumAmount
      public payable
    {
        // NOTE: [1] Do we need any requirements?
        // NOTE: [2] What if a user/address sends multiple requests?
        // NOTE: [3] Do we need a NONCE to keep track of transaction requests from the user?
    
        // TODO:
        //      [1] What if a user/address sends multiple requests?
        //

        MintingAmount[msg.sender] = msg.value;
        // --- Transaction Variables ---
        string memory strAmount = Math.uint2str(msg.value);
        address[] memory oracleList = bdg.getOracles();

        // Send out all Chainlink Requests.
        for (uint i=0; i < oracleList.length; i++) {

            address oracle = oracleList[i];
            bytes32[] memory jobIds = bdg.getJobIds(oracle);

            // TODO: Get bridge job for specific chain to specific job.
            Chainlink.Request memory request = buildChainlinkRequest(jobIds[0], address(this), this.fulfillTokenTransfer.selector);

            // Set the Endpoint with the parameter for the amount of WEI
            request.add("transfer", strAmount);

            request.add("address", rcvAddress);

            // Sends the request
            sendChainlinkRequestTo(oracle, request, fee);
        }
        
    }
    

    /**
     * fulfillTokenTransfer()
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
    function fulfillTokenTransfer(
        bytes32 _requestId,
        bytes32 _strMinted
    ) public recordChainlinkFulfillment(_requestId)
    {
        //TODO: This should aggregate the responses and establish a final result.

        uint256 _minted = Math.asciiToInteger(_strMinted);

        // We want to check and make sure that the amount minted is the correct amount and no additional values where 
        // Calculate Balance:
        //      - We need to calculate the balance from the original 
        uint256 _balance = address(this).balance;

        if(_balance != _minted) {
            emit Success(msg.sender, _requestId, false, _minted);    // Contract was successfully filled.
        } else {
            emit Success(msg.sender, _requestId, true, _minted);   // Contract did not successfully fill.
                                                                    // TODO: We want to "cancel" the order and return funds to user.
        }
        
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