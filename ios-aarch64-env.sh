#!/bin/bash
if [ "$IOS_SCRIPTS" = "" ]; then
  echo "IOS_SCRIPTS environment variable is not set"
  exit 1
fi

if [ "$EPIDEMIC_IOS_BUILD_DIR" = "" ]; then
  echo "EPIDEMIC_IOS_BUILD_DIR environment variable is not set"
  exit 1
fi

env -i bash EPIDEMIC_IOS_BUILD_DIR=$EPIDEMIC_IOS_BUILD_DIR --rcfile "$IOS_SCRIPTS/ios-aarch64-env.rc"