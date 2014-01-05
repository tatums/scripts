#!/bin/bash
# A simple script to create and self sign a certificate



echo 'This is a script to generate a self signed cert.'
echo 'You will be asked for a domain name'
echo 'Four files will be produced based on the domain name'
echo 'for example... if I use tatum.local I should have the following four files:'
echo 'tatum.local.crt, tatum.local.csr, tatum.local.key, tatum.local.key.orig'

echo ''
echo 'Provide a name for the RSA key'
read name

certificate_key="$name.key"
certificate_signing_request="$name.csr"
certificate="$name.crt"
originial_certificate_key="$certificate_key.orig"

## generate the key
printf "\n\n1. Creating the RSA key \n\n"
openssl genrsa -des3 -out $certificate_key 2048

## create the singing request
printf "\n\n2. Creating the singing request \n\n"
openssl req -new -key $certificate_key -out $certificate_signing_request

printf "\n\n3. Backing up the original key and removing the password \n\n"
cp $certificate_key $originial_certificate_key
openssl rsa -in $originial_certificate_key -out $certificate_key

printf "\n\n4. Self-signing the cert \n\n"
openssl x509 -req -days 3650 -in $certificate_signing_request -signkey $certificate_key -out $certificate

