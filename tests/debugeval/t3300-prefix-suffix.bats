#!/usr/bin/env bats

load fixture

@test "with DEBUGGEE^=PREFIX, command is prefixed" {
    DEBUG=debuggee^=time\  run -0 debugcallSimpleCommand
    assert_output 'time echo just a\ test'
}

@test "multiple DEBUGGEE^=PREFIX are concatenated" {
    DEBUG=debuggee^=time\ ,debuggee^=verbose\  run -0 debugcallSimpleCommand
    assert_output 'verbose time echo just a\ test'
}

@test "with DEBUGGEE+=SUFFIX, command is suffixed" {
    DEBUG=debuggee+=. run -0 debugcallSimpleCommand
    assert_output 'echo just a\ test.'
}

@test "multiple DEBUGGEE+=SUFFIX are concatenated" {
    DEBUG=debuggee+=\ to,debuggee+=\ check\\\! run -0 debugcallSimpleCommand
    assert_output 'echo just a\ test to check\!'
}

@test "multiple DEBUGGEE^=PREFIX and DEBUGGEE+=SUFFIX among other TESTEEs" {
    DEBUG=debuggee+=ing\ run,aDifferentDebuggee+=X,debuggee^=verbose\ ,aDifferentDebuggee^=echo\ ,debuggee+='\?' run -0 debugcallSimpleCommand
    assert_output 'verbose echo just a\ testing run\?'
}
