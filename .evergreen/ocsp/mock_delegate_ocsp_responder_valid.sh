#!/usr/bin/env sh
python3 ocsp_mock.py \
  --ca_file ca_ocsp.pem \
  --ocsp_responder_cert ocsp_responder.crt \
  --ocsp_responder_key ocsp_responder.key \
   -p 8100 \
   -v
