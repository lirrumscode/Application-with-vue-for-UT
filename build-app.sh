#!/bin/bash

npm run build

rm -rf ./ubports-app/www/
mkdir -p ./ubports-app/www/
cd ./ubports-app
