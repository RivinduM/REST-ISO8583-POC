// Copyright (c) 2025 WSO2 LLC. (https://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/constraint;
import ballerina/http;

import ballerina/log;
import ballerina/mime;
import ballerina/tcp;

import ballerinax/financial.iso8583;

# A service representing a network-accessible API
# bound to port `9090`.
#
listener http:Listener securedEP = new (9090,
    secureSocket = {
        key: {
            certFile: "resources/transport.pem",
            keyFile: "resources/transport.key"
        }
    }
);

service / on securedEP {

    # POST resource endpoint to recieve transaction requests generate and send TCP messages and response back.
    #
    # + transactionRequest - transaction request object
    # + return -transaction response object
    resource function post transactions/fundTransfer/single(@http:Payload {mediaType: mime:APPLICATION_FORM_URLENCODED}
            map<string> transactionRequest) returns TransactionResponse|error {

        log:printDebug(string `[REST endpoint] Received request`, transactionRequest = transactionRequest);
        TransactionMessage|error transactionMessage = transactionRequest.cloneWithType(TransactionMessage);
        if transactionMessage is TransactionMessage {
            MTI_1200 mti200Message = buildMTI0200Message(transactionMessage);
            log:printDebug(string `[REST endpoint] MTI 1200 message ` + mti200Message.toJsonString());

            string|iso8583:ISOError encodedMsg = iso8583:encode(mti200Message);
            if encodedMsg is string {
                // Send the desired content to the server.
                tcp:Client socketClient = check new ("localhost", 9095);
                log:printDebug(string `[REST endpoint] Sending encoded message to tcp server`, encodedMsg = encodedMsg);
                // Convert the message to a byte array.
                byte[]|error iso8583bytes = generateBytes(encodedMsg, "", true);
                if iso8583bytes is byte[] {
                    log:printDebug(string `[REST endpoint] Encoded Byte array`, byteArray = iso8583bytes.toString());
                    check socketClient->writeBytes(iso8583bytes);
                    // Read the response from the server.
                    readonly & byte[] receivedData = check socketClient->readBytes();
                    // Close the connection between the server and the client.
                    check socketClient->close();

                    // decode the byte stream
                    [string, string, string]|error [mti, bitmaps, convertedDataString] = decodeByteStream(receivedData);

                    log:printDebug(string `[REST endpoint] Decoded response message successfully.`,
                            MTI = mti, Bitmaps = bitmaps, Data = convertedDataString);
                    string msgToParse = mti + bitmaps + convertedDataString;
                    log:printDebug(string `[REST endpoint] Parsing the iso 8583 message.`, Message = msgToParse);

                    anydata|iso8583:ISOError parsedISO8583Msg = iso8583:parse(msgToParse);

                    // Convert the received data to a string.
                    if parsedISO8583Msg is iso8583:ISOError {
                        log:printError(string `[REST endpoint] Error while parsing message`, 
                            errorMsg = parsedISO8583Msg.message);
                    } else {
                        MTI_1210 validatedMsg = check constraint:validate(parsedISO8583Msg);
                        log:printDebug(string `[REST endpoint] Parsed response message successfully`, 
                            message = validatedMsg.toJsonString());
                        // Process the parsed message and extract the required information.
                        TransactionResponse transactionResponse = {
                            Status: "SUCCESS",
                            ErrorList: [],
                            TraceId: transactionMessage.referenceValue,
                            StatusCode: "200",
                            Result: {
                                TransactionId: "31B50AC98758286CE0640050569FDD32",
                                ReferenceId: validatedMsg.RetrievalReferenceNumber,
                                ReferenceDate: "2025-04-01T14:52:52.4922349+05:30",
                                IsInternal: false,
                                ChargeAmount: 0.0
                            }
                        };
                        return transactionResponse;
                    }
                } else {
                    log:printError(string `[REST endpoint] Error while building 8583 response`, iso8583bytes);
                    // return error("Error while building 8583 response");
                }

            } else {
                log:printError(string `[REST endpoint] Error while encoding message ` + encodedMsg.message);
                // return error("Error while encoding message");
            }
            TransactionResponse transactionResponse = {
                Status: "FAILURE",
                ErrorList: [],
                TraceId: transactionMessage.referenceValue,
                StatusCode: "400",
                Result: {
                    TransactionId: "31B50AC98758286CE0640050569FDD32",
                    ReferenceId: transactionMessage.referenceValue,
                    ReferenceDate: "2025-04-01T14:52:52.4922349+05:30",
                    IsInternal: false,
                    ChargeAmount: 0.0
                }
            };
            return transactionResponse;
        }
        log:printError(string `[REST endpoint] Invalid incoming request`, transactionMessage);
        return error("Invalid transaction request");
    }
}
