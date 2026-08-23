#!/bin/bash

${DEBUG:+debuglog This is the script invoked by the main script.}
${DEBUG:+eval $(debugtrace --description 'subordinate script' --to "${DEBUG_LOGDIR}${DEBUG_LOGDIR:+/}subordinate.trc.log" -o $- -- "$@")}

echo "This is $*."
