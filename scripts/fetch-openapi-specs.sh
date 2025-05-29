#!/bin/bash
set -euo pipefail

echo "📥 Descargando OpenAPI specs..."
mkdir -p static/openapi/backoffice

curl --fail --retry 5 --retry-delay 5 https://api.stg.belo.app/v1/docs/json -o static/openapi/v1.json
curl --fail --retry 5 --retry-delay 5 https://api.stg.belo.app/v2/docs/json -o static/openapi/v2.json
curl --fail --retry 5 --retry-delay 5 https://api.stg.belo.app/payment/docs/json -o static/openapi/payment.json
curl --fail --retry 5 --retry-delay 5 https://api.stg.belo.app/v1/docs/json -o static/openapi/_v3.json
curl --fail --retry 5 --retry-delay 5 https://frigg.stg.belo.link/v1/docs/json -o static/openapi/crypto.json
curl --fail --retry 5 --retry-delay 5 https://api.stg.baldr.app/api/docs/json -o static/openapi/backoffice/api.json
curl --fail --retry 5 --retry-delay 5 https://api.stg.baldr.app/dashboard/docs/json -o static/openapi/backoffice/dashboard.json
curl --fail --retry 5 --retry-delay 5 https://api.stg.baldr.app/public/docs/json -o static/openapi/backoffice/public.json

echo "✅ Specs descargados correctamente."
