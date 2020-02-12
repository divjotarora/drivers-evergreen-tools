#!/usr/bin/env sh
# Use the CA as the OCSP responder (see https://community.letsencrypt.org/t/unable-to-verify-ocsp-response/7264)
python3 ocsp_mock.py \
  --ca_file ecdsa-ca-ocsp.pem \
  --ocsp_responder_cert ecdsa-ca-ocsp.crt \
  --ocsp_responder_key ecdsa-ca-ocsp.key \
   -p 8100 \
   -v
