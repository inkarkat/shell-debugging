#!/bin/bash

${DEBUG:+eval $(debugtrace --description 'surordinate script' --to subordinate.trc -- "$@")}

echo "This is $*."
