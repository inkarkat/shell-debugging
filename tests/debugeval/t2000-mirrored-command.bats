#!/usr/bin/env bats

load fixture

@test "without DEBUG, the command is mirrored back" {
    run -0 debugcallSimpleCommand
    assert_output ' echo just a\ test'	# Note: Leading space due to the printf format string.
}

@test "without DEBUG, the command-line is mirrored back" {
    run -0 debugcallCommandLine
    assert_output 'echo just a\ test'
}

@test "with different DEBUGGEE target, the command is mirrored back" {
    DEBUG=aDifferentDebuggee run -0 debugcallSimpleCommand
    assert_output 'echo just a\ test'
}

@test "with different DEBUGGEE target, the command-line is mirrored back" {
    DEBUG=aDifferentDebuggee run -0 debugcallCommandLine
    assert_output 'echo just a\ test'
}

@test "with DEBUGGEE targeting, the command is mirrored back" {
    DEBUG=debuggee run -0 debugcallSimpleCommand
    assert_output 'echo just a\ test'
}

@test "with DEBUGGEE targeting, the command-line is mirrored back" {
    DEBUG=debuggee run -0 debugcallCommandLine
    assert_output 'echo just a\ test'
}
