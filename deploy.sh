#!/bin/bash

# Asegúrate de tener configurado las credenciales de AWS y las regiones

STAGE=$1

if [ -z "$STAGE" ]; then
  echo "Uso: ./deploy.sh <stage>"
  exit 1
fi

# Construye la aplicación
sam build

# Implementa la aplicación en el entorno especificado
sam deploy --stack-name "fastapi-mangum-${STAGE}" --s3-bucket "<your_s3_bucket>" --capabilities CAPABILITY_IAM --parameter-overrides Stage="${STAGE}"

# Reemplaza "<your_s3_bucket>" con el nombre de tu bucket de S3 donde se almacenará el código fuente.
