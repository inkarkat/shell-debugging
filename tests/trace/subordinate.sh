#!/bin/bash

${DEBUG:+eval $(debugtrace --description 'surordinate script' --to subordinate.trc -o $- -- "$@")}

echo "This is $*."
