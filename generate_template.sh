#!/bin/bash

HORA=`date '+%Y-%m-%d %H:%M:%S'`
echo "Creando template a las: $HORA"

echo "AWSTemplateFormatVersion: '2010-09-09'" > template.yaml
echo "Transform: 'AWS::Serverless-2016-10-31'" >> template.yaml
echo "Resources:" >> template.yaml
echo "  zeitplanFuncion:" >> template.yaml
echo "    Type: 'AWS::Serverless::Function'" >> template.yaml
echo "    Properties:" >> template.yaml
echo "      Handler: main.handler" >> template.yaml
echo "      Runtime: python3.8" >> template.yaml
echo "      CodeUri: ." >> template.yaml
echo "      Timeout: 10" >> template.yaml
echo "      Events:" >> template.yaml

for api_routes_file in $(find app/api/* -name "routes.py"); do
  # Extract the API ID, route and method from the routes file
  api_id=$(grep -oE "api_id\s*=\s*['\"](.*)['\"]" "$api_routes_file" | awk -F '"' '{print $2}')
  api_route=$(grep -oE "api_route\s*=\s*['\"](.*)['\"]" "$api_routes_file" | awk -F '"' '{print $2}')
  metodo=$(grep -oE "metodo\s*=\s*['\"](.*)['\"]" "$api_routes_file" | awk -F '"' '{print $2}')

  # Construct the API name and add it to the template
  api_name=$(echo "$api_id" | tr "." "_")
  echo "        ${api_name}:" >> template.yaml
  echo "          Type: Api" >> template.yaml
  echo "          Properties:" >> template.yaml
  echo "            Path: ${api_route}" >> template.yaml
  echo "            Method: ${metodo}" >> template.yaml
done

echo "Finalizando template a las: $HORA"
