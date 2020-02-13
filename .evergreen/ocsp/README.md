# Generating Test Certificates

The test certificates here were generating using a fork of the server team's [`mkcert.py`](https://github.com/mongodb/mongo/blob/master/jstests/ssl/x509/mkcert.py) tool.

In order to generate a fresh set of certificates, clone this branch of my fork of the [`mongo` repository](https://github.com/vincentkam/mongo/tree/mkcert-ecdsa) and run the following commands from the root of the `mongo` repository:

`python3 jstests/ssl/x509/mkcert.py --config ../drivers-evergreen-tools/.evergreen/ocsp/rsa/certs.yml`
`python3 jstests/ssl/x509/mkcert.py --config ../drivers-evergreen-tools/.evergreen/ocsp/ecdsa/certs.yml`

Passing a certificate ID as the final parameter will limit certificate generation to that certificate and all its leaves.

The certificates will be output into the folder specified by the `global.output_path` option in each `certs.yml` file, which default to the `rsa` and `ecsda` directories contained in this directory. The default configuration also assumes that the `mongo` repository and the `driver-evergreen-tools` repository have the same parent directory.

The next step is to split the `rsa/ca.pem` file, which contains both the private key and the public certificate, into two files. `rsa/ca.crt` should contain the public certificate, and `ras/ca.key` should contain the private certificate.

The final step is to normalize the ECDSA certificate names by running `ecdsa/rename.sh`.
