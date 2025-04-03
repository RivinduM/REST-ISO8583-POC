# REST API to ISO 8583 TCP Service
This is a sample project demonstrating the Ballerina capability to transform REST API payload to ISO 8583 format and 
transmit it to a TCP server, and receive the response back in ISO 8583 format, decode it, and send it back to the REST API client.
## Message flow
1. REST API receives transaction message with all necessary details to generate the ISO 8583 message.
2. Validate incoming request.
3. Build 8583 MTI 1200 message.
4. Convert to byte array.
5. Transmit to TCP listener.
6. Listen and receive response from TCP server.
7. Decode tcp response and extract required fields.
8. Generate and send REST API response.

## Assumptions
- All data required for ISO 8583 MTI 200 message generation available at the REST endpoint.
- Based on the received example message, the ISO spec seems ISO8583:1993. Since there are custom flavors of the standard spec, some fields are customized to suite the given example request response messages. If we are to deploy this, need the exact specification to configure the parser.
- POC developed to send MTI 1200 messages and receive MTI 1210 messages from tcp server. This can be extended to support other MTIs.

### Mock TCP listener
- Listens incoming TCP messages and log the incoming request.
- Responds a hard coded 8583 MTI 1200 message.

## Quick Start Guide

1. Locate iso8583_service directory.
2. Run the following command to start the REST API service.
   ```bash
   bal run
   ```
3. Locate tcp_mock_service directory.
4. Run the following command to start the TCP listener.
   ```bash
    bal run 
    ```
5. Try out the following curl command to test the REST API.
   ```bash
    curl --location 'https://localhost:9090/transactions/fundTransfer/single' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'processingCode=401000' \
    --data-urlencode 'referenceValue=123456' \
    --data-urlencode 'auxNo=D6538AC1E4FD466DAFF7CD5589360E44' \
    --data-urlencode 'fromAccId=200300006317' \
    --data-urlencode 'toAccId=200300008212' \
    --data-urlencode 'transactionAmount=1111' \
    --data-urlencode 'curId=144' \
    --data-urlencode 'channelType=mobile' \
    --data-urlencode 'referenceValue=123456' \
    --data-urlencode 'dateTime=20250401145350' \
    --data-urlencode 'destinationBankCode=111111' \
    --data-urlencode 'messageId=509114665372' \
    --data-urlencode 'narration=99144D000000000000000000000000D0000000000000000144' \
    --data-urlencode 'accountIdentification2=008053513502'
   ```
