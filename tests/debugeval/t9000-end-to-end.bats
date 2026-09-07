#!/usr/bin/env bats

load fixture

testSimpleCommand()
{
    eval "$(${DEBUG:+debugeval --for debuggee --} "${DEBUG:-printf}" "${DEBUG:- %q}" echo the '"quick"' brown '/fox\' jumps over an ol\'dog)"
}

testCommandLine()
{
    eval "$(${DEBUG:+debugeval --for debuggee --command} "${DEBUG:-echo}" "echo the \\\"quick\\\" brown /fox\\\\ jumps over an ol\\'dog")"
}

assertCall()
{
    assert_output "the \"quick\" brown /fox\\ jumps over an ol'dog"
}

@test "without DEBUG, the command is executed" {
    run -0 testSimpleCommand
    assertCall
}

@test "without DEBUG, the command-line is mirrored back" {
    run -0 testCommandLine
    assertCall
}

@test "with different DEBUG target, the command is mirrored back" {
    DEBUG=aDifferentDebuggee run -0 testSimpleCommand
    assertCall
}

@test "with different DEBUG target, the command-line is mirrored back" {
    DEBUG=aDifferentDebuggee run -0 testCommandLine
    assertCall
}

@test "with DEBUG targeting, the command is mirrored back" {
    DEBUG=debuggee run -0 testSimpleCommand
    assertCall
}

@test "with DEBUG targeting, the command-line is mirrored back" {
    DEBUG=debuggee run -0 testCommandLine
    assertCall
}
