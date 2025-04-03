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

import ballerina/io;
import ballerina/lang.array;
import ballerina/log;
import ballerina/tcp;

// Bind the service to the port. 
service on new tcp:Listener(9095) {

    // This remote method is invoked when the new client connects to the server.
    remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService {
        log:printInfo(string `[TCP SERVICE] Client connected to echo server`, port = caller.remotePort);
        return new EchoService();
    }
}

service class EchoService {
    *tcp:ConnectionService;

    // This remote method is invoked once the content is received from the client.
    remote function onBytes(tcp:Caller caller, readonly & byte[] data) returns tcp:Error? {
        string hex = array:toBase16(data);
        log:printDebug("[TCP SERVICE] Received message to the TCP listener: " + hex);
        // Echoes back the data to the client from which the data is received.
        string responseMessage = "3032363931323130f03080010e85800000000000000000263132323030333030303036333137343031303030303030303030303031313131363635333732323032353034303131343533353032303235303430313036313131313131353039313134363635333732554e49303030303030443635333841433130353039394c4b524430303030303030303030303030303030303030303030303044303030303030303030303030303030304c4b52303638433030303235323132303233394330303031313632303637303843303030303030303030303030433030303030303030303030304330303031313632303637303831343431343430303343465430303443454654303039202053363637303038";
        log:printDebug("[TCP SERVICE] Sending response message in the TCP channel: " + responseMessage);
        byte[]|error response = array:fromBase16(responseMessage);
        if response is error {
            log:printError("[TCP SERVICE] Error while converting to byte array: " + response.message());
            return;
        }
        check caller->writeBytes(response);
    }

    // This remote method is invoked in an erroneous situation,
    // which occurs during the execution of the `onConnect` or `onBytes` method.
    remote function onError(tcp:Error err) {
        log:printError("An error occurred", 'error = err);
    }

    // This remote method is invoked when the connection is closed.
    remote function onClose() {
        io:println("Client left");
    }
}
