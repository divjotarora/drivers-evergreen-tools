#!/usr/bin/env sh
python3 ocsp_mock.py \
  --ca_file ecdsa-ca-ocsp.pem \
  --ocsp_responder_cert ecdsa-ca-ocsp.crt \
  --ocsp_responder_key ecdsa-ca-ocsp.key \
   -p 8100 \
   -v
