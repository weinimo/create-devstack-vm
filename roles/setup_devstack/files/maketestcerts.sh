#!/bin/bash

set -e

mkdir testca
cd testca

mkdir newcerts private
chmod 700 private

touch index.txt
echo 01 > serial

openssl genrsa -passout pass:changeme -des3 -out private/cakey.pem 2048

openssl req -x509 -passin pass:changeme -new -nodes -key private/cakey.pem \
        -config ~/scripts/openssl.cnf \
        -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
        -days 3650 \
        -out ca_cert.pem

openssl req \
       -newkey rsa:2048 -nodes -keyout testcert.key \
       -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
       -out testcert.csr

openssl ca -passin pass:changeme -config ~/scripts/openssl.cnf -in testcert.csr \
           -days 3650 -out testcert.pem -batch

cat testcert.pem testcert.key > testcert-key-bundle.pem

openssl pkcs12 -export -nodes -inkey testcert.key -in testcert.pem -certfile ca_cert.pem -out testcert.p12
