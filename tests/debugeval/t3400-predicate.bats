#!/usr/bin/env bats

load sink

@test "with DEBUGGEE?PREDICATE targeting, the invocation is recorded only if PREDICATE is true" {
    DEBUG=debuggee:testmodule1\?true run -0 debugcallSimpleCommand --module testmodule1
    DEBUG=debuggee:testmodule2\?false run -0 debugcallSimpleCommand --module testmodule2
    assert_sink_contains 'echo just a\\ test' testmodule1
    assert_sink_not_contains 'echo just a\\ test' testmodule2
}

@test "with DEBUGGEE?PREDICATE,DEBUGGEE!, the command is suppressed only if PREDICATE is true" {
    DEBUG=debuggee\?true,debuggee\! run -0 debugcallSimpleCommand
    assert_output ''

    DEBUG=debuggee\?false,debuggee\! run -0 debugcallSimpleCommand
    assert_output 'echo just a\ test'
}

@test "complex predicate that evaluates environment variable" {
    P=1 DEBUG=debuggee'?[ $P -gt 0 ]',debuggee\! run -0 debugcallSimpleCommand
    assert_output ''

    P=0 DEBUG=debuggee'?[ $P -gt 0 ]',debuggee\! run -0 debugcallSimpleCommand
    assert_output 'echo just a\ test'
}

@test "with DEBUGGEE?PREDICATE, DEBUGGEE=OTHER-COMMAND, command is replaced with a simple OTHER-COMMAND only if PREDICATE is true" {
    DEBUG=debuggee\?true,debuggee=uname run -0 debugcallSimpleCommand
    assert_output 'uname'

    DEBUG=debuggee\?false,debuggee=uname run -0 debugcallSimpleCommand
    assert_output 'echo just a\ test'
}

@test "with DEBUGGEE?PREDICATE,DEBUGGEE@FILE, command is skipped and the contents of FILE are used as output only if PREDICATE is true" {
    DEBUG="debuggee?true,debuggee@${BATS_TEST_DIRNAME}/canned.txt" run -0 debugcallSimpleCommand
    printf -v expected 'cat %q' "${BATS_TEST_DIRNAME}/canned.txt"
    assert_output "$expected"

    DEBUG="debuggee?false,debuggee@${BATS_TEST_DIRNAME}/canned.txt" run -0 debugcallSimpleCommand
    assert_output 'echo just a\ test'
}

@test "with DEBUGGEE?PREDICATE,DEBUGGEE^=PREFIX, command is prefixed only if PREDICATE is true" {
    DEBUG=debuggee\?true,debuggee^=time\  run -0 debugcallSimpleCommand
    assert_output 'time echo just a\ test'

    DEBUG=debuggee\?false,debuggee^=time\  run -0 debugcallSimpleCommand
    assert_output 'echo just a\ test'
}
