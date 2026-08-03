#!/bin/bash

${DEBUG:+debuglog This is the script invoked by the main script.}
${DEBUG:+eval $(debugtrace --description 'subordinate script' --to subordinate.trc.log -o $- -- "$@")}

echo "This is $*."
