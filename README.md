# kitura-sslbug

This project demonstrates write/read errors with a Kitura server, which has been setup to work with HTTPS.

Errors do not occurr with small files, but they generally do occur with larger files and the transfer gets truncated.

The server logs write errors on Linux, and read errors on Mac. In both cases, the file rarely finishes the transfer.

This sample project includes a 1.7 MB image. Usually 1 out of 4 tries finish the transfer on Linux, but it almost never completes on Mac. To access that image, use the following url:

```
https://localhost:8090/large.jpg
```

Included below, are the errors logged by both **OS X** and **Linux**.

# Certificates

Certificates are self-signed and have been created using the shell script in:

```
Certs/create-certificates.sh
```

The script will create the following files:

| File     | Description                                |
| -------- | ------------------------------------------ |
| cert.pem | Linux: SSL certificate                     |
| key.pem  | Linux: private key                         |
| cert.pfx | OS X: combined file with certificate + key |

# OS X errors

```
[2017-03-18T09:52:42.811+01:00] [INFO] [HTTPServer.swift:86 listen(on:)] Listening on port 8090 (delegate: SSLService.SSLService)
[2017-03-18T09:52:44.590+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 7) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T09:52:44.599+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 8) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T09:52:44.680+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 7) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T09:52:56.443+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 8) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T09:52:56.547+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 8) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T09:52:56.574+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 7) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T09:52:57.759+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 7) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T09:52:57.863+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 7) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T09:52:57.890+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 8) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T09:52:59.930+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 8) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T09:53:00.034+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 8) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T09:53:00.060+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 7) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
```
# Linux errors (using docker ibmcom/kitura-ubuntu)

```
[2017-03-18T09:37:11.468Z] [INFO] [HTTPServer.swift:86 listen(on:)] Listening on port 8090 (delegate: SSLService.SSLService)
[2017-03-18T09:37:29.863Z] [ERROR] [IncomingSocketHandler.swift:265 handleWriteHelper()] Write to socket (file descriptor 6) failed. Error = Error code: 336195711(0x1409F07F), ERROR: SSL_write, code: 336195711, reason: bad write retry.
[2017-03-18T09:37:44.804Z] [ERROR] [IncomingSocketHandler.swift:265 handleWriteHelper()] Write to socket (file descriptor 6) failed. Error = Error code: 336195711(0x1409F07F), ERROR: SSL_write, code: 336195711, reason: bad write retry.
[2017-03-18T09:37:51.153Z] [ERROR] [IncomingSocketHandler.swift:265 handleWriteHelper()] Write to socket (file descriptor 7) failed. Error = Error code: 336195711(0x1409F07F), ERROR: SSL_write, code: 336195711, reason: bad write retry.
[2017-03-18T09:37:59.057Z] [ERROR] [IncomingSocketHandler.swift:265 handleWriteHelper()] Write to socket (file descriptor 6) failed. Error = Error code: 336195711(0x1409F07F), ERROR: SSL_write, code: 336195711, reason: bad write retry.
```

