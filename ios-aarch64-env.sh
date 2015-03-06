#!/bin/bash
if [ "$IOS_SCRIPTS" = "" ]; then
  echo "IOS_SCRIPTS environment variable is not set"
  exit 1
fi

env -i bash --rcfile "$IOS_SCRIPTS/ios-aarch64-env.rc"