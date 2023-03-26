#!/bin/bash

HORA=`date '+%Y-%m-%d %H:%M:%S'`

echo "Comenzando Deploy a las: $HORA"

set -e

echo "Crear la carpeta para la capa Lambda"
mkdir -p python/lib/python3.8/site-packages/

echo "Copiar el contenido del venv a la carpeta de la capa"
rm -rf python/lib/python3.8/site-packages/*
find venv/Lib/site-packages/ -type f ! -path "*dist-info*" -exec cp {} python/lib/python3.8/site-packages/ \;

echo "Crear el archivo zip de la capa"
cd python/
zip -r9 ../layer-zeitplan.zip .

echo "Subir la capa a AWS"

LAYER_VERSION=$(aws lambda publish-layer-version --layer-name layer-zeitplan --description "Layer Zeitplan" --zip-file fileb://../layer-zeitplan.zip --region us-east-1 --cli-connect-timeout 6000)
echo $LAYER_VERSION
LAYER_ARN=$(echo $LAYER_VERSION | grep -o "\"LayerVersionArn\": \"arn:aws:lambda:[^\"]*\"" | sed -E 's/.*"arn:aws:lambda:([^"]*)".*/arn:aws:lambda:\1/')
echo $LAYER_ARN

echo "Subir el zip de la capa a S3"
aws s3 cp ../layer-zeitplan.zip s3://layer-zeitplan/layer-zeitplan.zip

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "Actualizar la propiedad 'ContentUri' del recurso 'zeitplanFuncion'"
powershell -Command "(Get-Content ./template.yaml) -replace 'ContentUri:.*', 'ContentUri: s3://layer-zeitplan/layer-zeitplan.zip' | Set-Content ./template.yaml"
#sed -i "s/ContentUri:.*/ContentUri: s3:\/\/layer-zeitplan\/layer-zeitplan.zip/" ./zeitplan_project/template.yaml

echo "Desplegar la aplicación"
'/c/Program Files/Amazon/AWSSAMCLI/bin/sam.cmd' deploy --stack-name zeitplan-stack-v3 --s3-bucket zeitplan-cl-v2 --capabilities CAPABILITY_IAM --region us-east-1 --template-file template.yaml

echo "Finished deploying: $HORA"

