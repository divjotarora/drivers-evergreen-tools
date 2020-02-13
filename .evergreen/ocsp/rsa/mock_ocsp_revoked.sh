#!/usr/bin/env sh
python3 ocsp_mock.py \
  --ca_file ca_ocsp.pem \
  --ocsp_responder_cert ca_ocsp.crt \
  --ocsp_responder_key ca_ocsp.key \
   -p 8100 \
   -v \
   --fault revoked
