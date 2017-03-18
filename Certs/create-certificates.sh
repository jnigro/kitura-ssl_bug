#!/bin/bash

## generate an RSA key (private key key.pem)
openssl genrsa -out key.pem 2048

## create cert signing request (CSR) used (by the authority) to generate the SSL certificate
openssl req -new -sha256 -key key.pem -out csr.csr -subj "/C=ES/ST=Some State/L=Some City/O=Some Organization/CN=hostname.local"

## create cert
openssl req -x509 -sha256 -days 3650 -key key.pem -in csr.csr -out cert.pem

## convert cert into PKCS#12 format:
openssl pkcs12 -export -out cert.pfx -inkey key.pem -in cert.pem

## remove certificate request
rm csr.csr
