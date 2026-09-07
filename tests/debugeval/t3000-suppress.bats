#!/usr/bin/env bats

load fixture

@test "with DEBUGGEE!, the command is suppressed" {
    DEBUG=debuggee\! run -0 debugcallSimpleCommand
    assert_output ''
}
