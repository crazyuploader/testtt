#!/usr/bin/env bash

curl -sL api.devjugal.com/ip-info | jq
docker run crazyuploader/speedtest --server-id 15244 --accept-license --accept-gdpr
