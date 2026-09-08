#!/bin/bash source-this-script

eval "foo() { echo ${1:-foo}; }"
sleep 0.1
if [ "$USE_COMMANDLINE" ]; then
    eval "$(${DEBUG:+debugeval --for scriptlet --command} "${DEBUG:-echo}" "echo 'scriptlet done'")"
else
    eval "$(${DEBUG:+debugeval --for scriptlet --} "${DEBUG:-printf}" "${DEBUG:- %q}" echo 'scriptlet done')"
fi
