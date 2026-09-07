#!/bin/bash

load fixture

setup() {
    rm --force -- "${PWD}/debuggee.log"
}

assert_sink_contains() {
    local commandLine="${1?}"; shift
    local module="$1"; shift || :
    assert_file_exists "${PWD}/debuggee.log"
    assert_file_contains "${PWD}/debuggee.log" "^$(date +%F) [0-9]\\{2\\}:[0-9]\\{2\\}:[0-9]\\{2\\},[0-9]\\{3\\}Z +\\+ debuggee (${module}${module:+, }[0-9]\\+) ${commandLine}\$"
}

assert_sink_not_contains() {
    local commandLine="${1?}"; shift
    local module="$1"; shift || :
    assert_file_exists "${PWD}/debuggee.log"
    assert_file_not_contains "${PWD}/debuggee.log" "^$(date +%F) [0-9]\\{2\\}:[0-9]\\{2\\}:[0-9]\\{2\\},[0-9]\\{3\\}Z +\\+ debuggee (${module}${module:+, }[0-9]\\+) ${commandLine}\$"
}

assert_sink_equals() {
    assert_file_exists "${PWD}/debuggee.log"
    diff -y - --label expected "${PWD}/debuggee.log" <<<"${1?}"
}
