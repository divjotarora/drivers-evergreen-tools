#!/usr/bin/env sh
python3 ocsp_mock.py \
  --ca_file ecdsa-ca-ocsp.pem \
  --ocsp_responder_cert ecdsa-ocsp-responder.crt \
  --ocsp_responder_key ecdsa-ocsp-responder.key \
   -p 8100 \
   -v
