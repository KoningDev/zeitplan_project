#!/bin/bash

# Run generate_template.sh
./generate_template.sh

HORA=$(date '+%Y-%m-%d %H:%M:%S')

echo "Comenzando Deploy a las: $HORA"

set -e

echo "Crear la carpeta para las dependencias"
mkdir -p dependencies

echo "Instalar las dependencias en la carpeta 'dependencies'"
pip install -r requirements.txt --target dependencies

echo "Crear el archivo zip de las dependencias"
cd dependencies
zip -r9 ../dependencies.zip .
cd ..

echo "Eliminar la carpeta 'dependencies'"
rm -rf dependencies

echo "Desplegar la aplicación"
sam package --template-file template.yaml --output-template-file packaged.yaml --s3-bucket zeitplan-cl-bucket --region us-east-1
sam deploy --template-file packaged.yaml --stack-name zeitplan-stack --capabilities CAPABILITY_IAM --region us-east-1

echo "Terminando Deploy a las: $(date '+%Y-%m-%d %H:%M:%S')"
