## Assumptions
- All data required for ISO 8583 MTI 200 message generation available at the REST endpoint.
- Based on the received example message, the ISO spec seems ISO8583:1993. Since there are custom flavors of the standard spec, some fields are customized to suite the given example request response messages. If we are to deploy this, need the exact specification to configure the parser.
- POC developed to send MTI 1200 messages and receive MTI 1210 messages from tcp server. This can be extended to support other MTIs.

### Message flow
1. REST API receives transaction message with all necessary details to generate the ISO 8583 message.
2. Validate incoming request.
3. Build 8583 MTI 1200 message.
4. Convert to byte array.
5. Transmit to TCP listener.
6. Listen and receive response from TCP server.
7. Decode tcp response and extract required fields.
8. Generate and send REST API response.

### Mock TCP listener
- Listens incoming TCP messages and log the incoming request.
- Responds a hard coded 8583 MTI 1200 messgae.

