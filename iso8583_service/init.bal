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

import ballerina/file;
import ballerina/log;

import ballerinax/financial.iso8583;

function init() returns error? {

    // initialize 8583 library with custom xml
    string|file:Error xmlFilePath = file:getAbsolutePath("resources/jposdefv87.xml");
    string|file:Error csvFilePath = file:getAbsolutePath("resources/nameIds.csv");
    if xmlFilePath is string && csvFilePath is string {
        log:printInfo(string `Initializing ISO 8583 library with the custom configurations`, 
            packagerFile = xmlFilePath, nameIdFile = csvFilePath);
        check iso8583:initialize(xmlFilePath, csvFilePath);
    } else {
        log:printWarn("Error occurred while getting the absolute path of the ISO 8583 configuration file. " +
                "Loading with default configurations.");
    }
}
