#!/usr/bin/env bats

load fixture

@test "with DEBUGGEE=OTHER-COMMAND, command is replaced with a simple OTHER-COMMAND" {
    DEBUG=debuggee=uname run -0 debugcallSimpleCommand
    assert_output 'uname'
}

@test "with DEBUGGEE=OTHER-COMMAND, command is replaced with a complex OTHER-COMMAND" {
    DEBUG=debuggee=grep\ \'my\ name\'\ /etc/passwd run -0 debugcallSimpleCommand
    assert_output "grep 'my name' /etc/passwd"
}

@test "DEBUGGEE=OTHER-COMMAND extraction among other TESTEEs" {
    DEBUG=aDifferentDebuggee=exit,debuggee=uname\ -a,yetAnotherDebuggee=who\ -a run -0 debugcallSimpleCommand
    assert_output 'uname -a'
}

@test "multiple DEBUGGEE=OTHER-COMMANDs are concatenated" {
    DEBUG=debuggee=uname\ -a,debuggee=uptime,aDifferentDebuggee=who\ -a,debuggee=sleep\ 10 run -0 debugcallSimpleCommand
    assert_output 'uname -a; uptime; sleep 10'
}
