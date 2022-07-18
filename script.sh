#!/usr/bin/env bash

curl -sL yabs.sh | bash
FILE=geekbench_claim.url
if [[ -f $FILE ]]; then
  cat $FILE
fi
