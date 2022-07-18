#!/usr/bin/env bash

curl -sLo hey https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64
chmod +x ./hey
mv hey /usr/bin
echo " Running... curl -sL http://ip-api.com/json/ | jq"
curl -sL http://ip-api.com/json/ | jq
echo ""
echo " Running... curl -sL api.devjugal.com/ip-info/ | jq"
curl -sL api.devjugal.com/ip-info/ | jq
echo ""
echo "Checking Performance for Server04"
hey -n 10000 https://server04.devjugal.com
