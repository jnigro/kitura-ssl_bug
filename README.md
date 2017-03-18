# kitura-ssl_bug

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
[2017-03-18T12:28:47.748+01:00] [INFO] [main.swift:43 kitura_ssl_bug] Using pfx file = /Users/javier/Documents/PlanB-Development/bug/kitura-ssl_bug/Certs/cert.pfx
[2017-03-18T12:28:48.373+01:00] [INFO] [HTTPServer.swift:86 listen(on:)] Listening on port 8090 (delegate: SSLService.SSLService)
[2017-03-18T12:28:52.651+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 7) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T12:28:52.672+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 8) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T12:28:55.723+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 8) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T12:28:55.827+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 8) failed. Error = Error code: -9806(0x-264E), ERROR: SSLRead, code: -9806, reason: errSSLClosedAbort.
[2017-03-18T12:28:55.855+01:00] [ERROR] [IncomingSocketHandler.swift:148 handleRead()] Read from socket (file descriptor 7) failed. Error = Error code: -36(0x-24), ERROR: SSLRead, code: -36, reason: errSecIO.
```
# Linux errors (using docker ibmcom/kitura-ubuntu)

```
[2017-03-18T11:32:10.389Z] [INFO] [main.swift:35 kitura_ssl_bug] Using key  file = /root/kitura-ssl_bug/Certs/key.pem
[2017-03-18T11:32:10.397Z] [INFO] [main.swift:36 kitura_ssl_bug] Using cert file = /root/kitura-ssl_bug/Certs/cert.pem
[2017-03-18T11:32:10.402Z] [INFO] [HTTPServer.swift:86 listen(on:)] Listening on port 8090 (delegate: SSLService.SSLService)
[2017-03-18T11:32:13.370Z] [ERROR] [IncomingSocketHandler.swift:265 handleWriteHelper()] Write to socket (file descriptor 7) failed. Error = Error code: 336195711(0x1409F07F), ERROR: SSL_write, code: 336195711, reason: bad write retry.
[2017-03-18T11:32:15.896Z] [ERROR] [IncomingSocketHandler.swift:265 handleWriteHelper()] Write to socket (file descriptor 7) failed. Error = Error code: 336195711(0x1409F07F), ERROR: SSL_write, code: 336195711, reason: bad write retry.
[2017-03-18T11:32:18.522Z] [ERROR] [IncomingSocketHandler.swift:265 handleWriteHelper()] Write to socket (file descriptor 7) failed. Error = Error code: 336195711(0x1409F07F), ERROR: SSL_write, code: 336195711, reason: bad write retry.
[2017-03-18T11:32:20.646Z] [ERROR] [IncomingSocketHandler.swift:265 handleWriteHelper()] Write to socket (file descriptor 7) failed. Error = Error code: 336195711(0x1409F07F), ERROR: SSL_write, code: 336195711, reason: bad write retry.

```

