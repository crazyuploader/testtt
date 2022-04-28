#!/usr/bin/env bash

curl -sLo hey https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64
chmod +x ./hey
echo "Checking Performance for Server03"
./hey -n 1000 https://server03.devjugal.com
echo "Checking Performance for Server04"
./hey -n 1000 https://server04.devjugal.com
