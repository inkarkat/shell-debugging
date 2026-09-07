#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert
bats_load_library bats-file

debugcallSimpleCommand()
{
    ${DEBUG:+debugeval --for debuggee $* --} "${DEBUG:-printf}" "${DEBUG:- %q}" echo just 'a test'
}

debugcallCommandLine()
{
    ${DEBUG:+debugeval --for debuggee $* --command} "${DEBUG:-echo}" 'echo just a\ test'
}
