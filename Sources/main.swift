import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

// Initialize HeliumLogger
HeliumLogger.use(LoggerMessageType.info)

// Get certificate and key paths
let certBasePath:String

if var fileUrl = URL(string: #file) {
    fileUrl.deleteLastPathComponent()
    fileUrl.deleteLastPathComponent()

    certBasePath = fileUrl.path
} else {
    Log.error("Unable to create absolute path for certificate path")
	exit(0)
}

// Create SSL config
let sslConfig:SSLConfig

#if os(Linux)
    
    let kFile = certBasePath + "/Certs/key.pem"
    let cFile = certBasePath + "/Certs/cert.pem"
    
    sslConfig = SSLConfig(withCACertificateDirectory: nil,
                          usingCertificateFile: cFile,
                          withKeyFile: kFile,
                          usingSelfSignedCerts: true)
    
	Log.info("Using key  file = \(kFile)")
	Log.info("Using cert file = \(cFile)")

#else
    
    let pfxFile = certBasePath + "/Certs/cert.pfx"
    sslConfig = SSLConfig(withChainFilePath: pfxFile, withPassword: "password", usingSelfSignedCerts: true)
    
	Log.info("Using pfx file = \(pfxFile)")

#endif

// Create a new router
let router = Router()

// Serve static content from "public"
router.all("/", middleware: StaticFileServer())

// Handle HTTP GET requests to /
router.get("/") {
    request, response, next in
    response.send("SSL successful!")
    next()
}

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8090, with: router, withSSL: sslConfig)

// Start the Kitura runloop (this call never returns)
Kitura.run()

