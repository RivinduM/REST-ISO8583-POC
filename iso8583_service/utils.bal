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

import ballerina/lang.array;

# Transform transaction message to MTI 1200 model.
# 
# + transactionMessage - The transaction message
# + return - The MTI 1200 message
function buildMTI0200Message(TransactionMessage transactionMessage) returns MTI_1200 => {
    PrimaryAccountNumber: transactionMessage.fromAccId,
    ProcessingCode: transactionMessage.processingCode,
    AmountTransaction: transactionMessage.transactionAmount,
    SystemsTraceAuditNumber: transactionMessage.referenceValue,
    DateAndTimeLocalTransaction: transactionMessage.dateTime,
    DateCapture: transactionMessage.dateTime.substring(0, 8),
    FunctionCode: "200",
    AcquiringInstitutionIdentificationCode: transactionMessage.destinationBankCode ?: "",
    RetrievalReferenceNumber: transactionMessage.messageId,
    CardAcceptorTerminalIdentification: transactionMessage.auxNo.substring(0,8),
    CardAcceptorNameLocation: transactionMessage.channelType + "                 " 
        + transactionMessage.channelType + "        " + "LKA",
    AmountsFees: transactionMessage.narration,
    CurrencyCodeTransaction: transactionMessage.curId,
    AccountIdentification1: transactionMessage.fromAccId,
    AccountIdentification2: transactionMessage.accountIdentification2,
    ReservedPrivateData123: "CFT", 
    ReservedPrivateData126: "CEFT"
};

# Build the byte array for the ISO8583 message.
#
# + msg - the ISO8583 message in string format
# + return - byte array of the ISO8583 message
function build8583ByteArray(string msg) returns byte[]|error {

    byte[] mti = msg.substring(0, 4).toBytes();

    int bitmapCount = check countBitmapsFromHexString(msg.substring(4));
    byte[] payload = msg.substring(4 + 16 * bitmapCount).toBytes();
    byte[] bitmaps = check array:fromBase16(msg.substring(4, 4 + 16 * bitmapCount));
    byte[] versionBytes = "".toBytes();
    int payloadSize = mti.length() + bitmaps.length() + payload.length() + versionBytes.length();
    string payloadSizeString = payloadSize.toString().padStart(4, "0");
    byte[] headerBytes = payloadSizeString.toBytes();
    return [...headerBytes, ...versionBytes, ...mti, ...bitmaps, ...payload];
}

# Count the number of bitmaps in a hex string.
#
# + data - hex string to be parsed
# + return - number of bitmaps
function countBitmapsFromHexString(string data) returns int|error {
    // parse the first character of the bitmap to determine whether there are more bitmaps
    int count = 1;
    int idx = 0;
    int a = check int:fromHexString(data.substring(idx, idx + 2));

    while (hasMoreBitmaps(a)) {
        count += 1;
        idx += 16;
        a = check int:fromHexString(data.substring(idx, idx + 2));
    }
    return count;
}

# Check if there are more bitmaps.
#
# + data - data to be checked
# + return - true if there are more bitmaps, false otherwise
function hasMoreBitmaps(int data) returns boolean {
    int mask = 1 << 7;
    int bitWiseAnd = data & mask;
    if (bitWiseAnd == 0) {
        return false;
    }
    return true;
}

# Convert a hex string to a string.
#
# + hexStr - hex string to be converted
# + return - string
function hexStringToString(string hexStr) returns string|error {
    byte[] byteArray = check array:fromBase16(hexStr);
    return check string:fromBytes(byteArray);
}

# Convert a string to a hex string.
#
# + str - string to be converted
# + return - hex string
function stringToHexString(string str) returns string|error {
    byte[] byteArray = str.toBytes();
    return array:toBase16(byteArray);
}
