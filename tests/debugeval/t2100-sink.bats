#!/usr/bin/env bats

load sink

@test "without DEBUG, no recording is done" {
    run -0 debugcallSimpleCommand
    assert_file_not_exists "${PWD}/debuggee.log"
}

@test "with different DEBUGGEE target, no recording is done" {
    DEBUG=aDifferentDebuggee run -0 debugcallSimpleCommand
    assert_file_not_exists "${PWD}/debuggee.log"
}

@test "with DEBUGGEE targeting, the invocation is recorded with timestamp in the current working directory" {
    BATS_TEST_TMPDIR='' DEBUG=debuggee run -0 debugcallSimpleCommand
    assert_sink_contains 'echo just a\\ test'
}

@test "multiple invocations are recorded" {
    DEBUG=debuggee run -0 debugcallSimpleCommand
    DEBUG=debuggee run -0 debugcallSimpleCommand
    DEBUG=debuggee run -0 debugcallSimpleCommand

    assert_file_exists "${PWD}/debuggee.log"
    assert_equal 3 "$(wc -l < "${PWD}/debuggee.log")"
}

@test "the invocation can be recorded to a custom DEBUG_LOGDIR file" {
    rm --force -- "${BATS_TMPDIR}/debuggee.txt"
    DEBUG_LOGDIR="$BATS_TMPDIR" DEBUG=debuggee run -0 debugcallSimpleCommand
    assert_file_not_exists "${PWD}/debuggee.log"
    assert_file_exists "${BATS_TMPDIR}/debuggee.log"
}

@test "the invocation can be recorded to a custom DEBUG_SINK file" {
    rm --force -- "${BATS_TMPDIR}/custom.txt"
    DEBUG_SINK="${BATS_TMPDIR}/custom.txt" DEBUG=debuggee run -0 debugcallSimpleCommand
    assert_file_not_exists "${PWD}/debuggee.log"
    assert_file_exists "${BATS_TMPDIR}/custom.txt"
}

@test "the invocation can be recorded to a custom DEBUGEVAL_SINK file that takes precedence over DEBUG_SINK" {
    rm --force -- "${BATS_TMPDIR}"/{eval,debug}.txt
    DEBUGEVAL_SINK="${BATS_TMPDIR}/eval.txt" DEBUG_SINK="${BATS_TMPDIR}/debug.txt" DEBUG=debuggee run -0 debugcallSimpleCommand
    assert_file_not_exists "${PWD}/debuggee.log"
    assert_file_not_exists "${BATS_TMPDIR}/debug.txt"
    assert_file_exists "${BATS_TMPDIR}/eval.txt"
}

@test "the invocation can be recorded to a custom DEBUG_SINK file descriptor " {
    DEBUG_SINK='&2' DEBUG=debuggee run -0 --separate-stderr debugcallSimpleCommand
    assert_file_not_exists "${PWD}/debuggee.log"
    output="$stderr" assert_output -e "^$(date +%F)"' [0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}Z \++ debuggee \([0-9]+\) echo just a\\ test$'
}

@test "the invocation can be recorded to an overriding DEBUG=debug[eval]=FILE file that takes precedence over everything else" {
    for var in debug{,eval}
    do
	rm --force -- "${BATS_TMPDIR}"/{eval,debug,override}.txt \
	&& DEBUGEVAL_SINK="${BATS_TMPDIR}/eval.txt" DEBUG_SINK="${BATS_TMPDIR}/debug.txt" DEBUG=debuggee,${var}="${BATS_TMPDIR}/override.txt" run -0 debugcallSimpleCommand \
	&& assert_file_not_exists "${PWD}/debuggee.log" \
	&& assert_file_not_exists "${BATS_TMPDIR}/eval.txt" \
	&& assert_file_not_exists "${BATS_TMPDIR}/debug.txt" \
	&& assert_file_exists "${BATS_TMPDIR}/override.txt" \
	|| fail "$var"
    done
}
