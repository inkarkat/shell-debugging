#!/usr/bin/env bats

load fixture

@test "with DEBUGGEE@FILE, command is skipped and the contents of FILE are used as output" {
    DEBUG="debuggee@${BATS_TEST_DIRNAME}/canned.txt" run -0 debugcallSimpleCommand
    printf -v expected 'cat %q' "${BATS_TEST_DIRNAME}/canned.txt"
    assert_output "$expected"
}

@test "with DEBUGGEE@N-FILE, command is skipped, the contents of FILE are used as output, and exit status is N" {
    DEBUG="debuggee@${BATS_TEST_DIRNAME}/42-canned.txt" run -0 debugcallSimpleCommand
    printf -v expected '(cat %q; exit 42)' "${BATS_TEST_DIRNAME}/canned.txt"
    assert_output "$expected"
}
