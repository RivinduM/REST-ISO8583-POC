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

# MTI 1200 - Financial Request.
# The `MTI_1200` record represents a financial request in the ISO 8583 standard.
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.
# + DateAndTimeLocalTransaction - The local date and time at the point of transaction.  
# + DateCapture - The date when the transaction data was captured.  
# + FunctionCode - The function code of the transaction.
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + RetrievalReferenceNumber - A reference number used to retrieve the transaction.  
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.
# + CardAcceptorNameLocation - The name and location of the card accepter.  
# + AmountsFees - The amount of fees associated with the transaction.
# + CurrencyCodeTransaction - The currency code of the transaction.  
# + AccountIdentification1 - The first account identification.  
# + AccountIdentification2 - The second account identification.  
# + ReservedPrivateData123 - private data field 123.
# + ReservedPrivateData126 - private data field 126.

public type MTI_1200 record {|
    string MTI = "1200";
    @constraint:String {
         pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for PrimaryAccountNumber"
        }
    }
    string PrimaryAccountNumber?;
    @constraint:String {
         pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ProcessingCode"
        }
    }
    string ProcessingCode;
    @constraint:String {
         pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountTransaction"
        }
    }
    string AmountTransaction;
    @constraint:String {
         pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for SystemsTraceAuditNumber"
        }
    }
    string SystemsTraceAuditNumber;
    @constraint:String {
         pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateAndTimeLocalTransaction"
        }
    }
    string DateAndTimeLocalTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateCapture"
        }
    }
    string DateCapture?;
    string FunctionCode?;
    @constraint:String {
         pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AcquiringInstitutionIdentificationCode"
        }
    }
    string AcquiringInstitutionIdentificationCode;
    @constraint:String {
         pattern: {
            value: re `^[a-zA-Z0-9]+$`,
            message: "Only alpha numeric values allowed for RetrievalReferenceNumber"
        }
    }
    string RetrievalReferenceNumber;
    string CardAcceptorTerminalIdentification?;
    string CardAcceptorNameLocation?;
    string AmountsFees?;
    @constraint:String {
         pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for CurrencyCodeTransaction"
        }
    }
    string CurrencyCodeTransaction;
    string AccountIdentification1?;
    string AccountIdentification2?;
    string ReservedPrivateData123?;
    string ReservedPrivateData126?;
|};


# MTI 1210 - Financial Request.
# The `MTI_1210` record represents a financial presentment request response in the ISO 8583 standard.
#
# + MTI - The message type indicator (MTI) of the transaction.  
# + PrimaryAccountNumber - The primary account number (PAN) of the cardholder.  
# + ProcessingCode - A code indicating the type of transaction being performed.  
# + AmountTransaction - The amount of the transaction.  
# + SystemsTraceAuditNumber - A unique number assigned to the transaction for tracking purposes.  
# + DateAndTimeLocalTransaction - The local date and time at the point of transaction.  
# + DateCapture - The date when the transaction data was captured.
# + AcquiringInstitutionIdentificationCode - The identification code of the acquiring institution.  
# + RetrievalReferenceNumber - A reference number used to retrieve the transaction.
# + ApprovalCode - The approval code of the transaction.  
# + ActionCode - The action code of the transaction.  
# + CardAcceptorTerminalIdentification - The identification code of the terminal where the card was accepted.  
# + AmountsFees - The amount of the transaction fees.  
# + AdditionalDataPrivate - additional data related to the transaction.
# + CurrencyCodeTransaction - The currency code of the transaction.
# + ReservedPrivateData123 - private data field 123.
# + ReservedPrivateData126 - private data field 126.  
# + ReservedPrivateData127 - private data field 127.

public type MTI_1210 record {|
    string MTI = "1210";
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for PrimaryAccountNumber"
        }
    }
    string PrimaryAccountNumber?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ProcessingCode"
        }
    }
    string ProcessingCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AmountTransaction"
        }
    }
    string AmountTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for SystemsTraceAuditNumber"
        }
    }
    string SystemsTraceAuditNumber;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateAndTimeLocalTransaction"
        }
    }
    string DateAndTimeLocalTransaction;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for DateCapture"
        }
    }
    string DateCapture?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for AcquiringInstitutionIdentificationCode"
        }
    }
    string AcquiringInstitutionIdentificationCode;
    @constraint:String {
         pattern: {
            value: re `^[a-zA-Z0-9]+$`,
            message: "Only alpha numeric values allowed for RetrievalReferenceNumber"
        }
    }
    string RetrievalReferenceNumber;
    string ApprovalCode?;
    @constraint:String {
        pattern: {
            value: re `^\d+`,
            message: "Only numeric values allowed for ActionCode"
        }
    }
    string ActionCode;
    string CardAcceptorTerminalIdentification?;
    string AmountsFees?;
    string AdditionalDataPrivate?;
    string CurrencyCodeTransaction;
    string ReservedPrivateData123?;
    string ReservedPrivateData126?;
    string ReservedPrivateData127?;
|};

# Transaction message.
#
# + auxNo - auxiliary number for the transaction.
# + messageId - message identifier for the transaction.
# + messageGroupId - message group identifier for the transaction.
# + cardNo - card number for the transaction.
# + fromAccId - account identifier for the sender.
# + fromAccLbl - account label for the sender.
# + toAccId - account identifier for the receiver.
# + toAccLbl - account label for the receiver.
# + orgBankCode - code of the originating bank.
# + destinationBankCode - code of the destination bank.
# + orgBranchCode - code of the originating branch.
# + destinationBranchCode - code of the destination branch.
# + transactionAmount - amount of the transaction.
# + curId - currency identifier for the transaction.
# + channelType - type of the channel used for the transaction.
# + narration - narration for the transaction.
# + mac - message authentication code for the transaction.
# + orriginatingAccountHolderName - name of the originating account holder.
# + referenceValue - reference value for the transaction.
# + transactionCode - code of the transaction.
# + processingCode - code for processing the transaction.
# + dateTime - date and time of the transaction.
# + accountIdentification2 - second account identification for the transaction.
public type TransactionMessage record {
    string auxNo;
    string messageId;
    string messageGroupId?;
    string cardNo?;
    string fromAccId;
    string fromAccLbl?;
    string toAccId;
    string toAccLbl?;
    string orgBankCode?;
    string destinationBankCode?;
    string orgBranchCode?;
    string destinationBranchCode?;
    string transactionAmount;
    string curId;
    string channelType;
    string narration?;
    string mac?;
    string orriginatingAccountHolderName?;
    string referenceValue;
    string transactionCode?;
    string processingCode;
    string dateTime;
    string accountIdentification2;
};

# Transaction messsge response model.
#
# + StatusCode - status code of the transaction response.
# + TraceId - trace identifier for the transaction.
# + Status - status of the transaction response.
# + ErrorList - list of errors associated with the transaction response.
# + Result - result of the transaction response.
public type TransactionResponse record {
    string StatusCode;
    string TraceId;
    string Status;
    string[] ErrorList;
    TransactionResult Result;
};

# Transaction result model.
#
# + TransactionId - transaction identifier for the transaction result.
# + ReferenceId - reference identifier for the transaction result.
# + ReferenceDate - reference date for the transaction result.
# + IsInternal - indicates if the transaction is internal.
# + ChargeAmount - charge amount for the transaction result.
public type TransactionResult record {
    string TransactionId;
    string ReferenceId;
    string ReferenceDate;
    boolean IsInternal;
    float ChargeAmount;
};
