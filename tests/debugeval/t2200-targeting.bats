#!/usr/bin/env bats

load sink

@test "with DEBUGGEE targeting, the invocation of any modules is not recorded" {
    DEBUG=debuggee run -0 debugcallSimpleCommand
    DEBUG=debuggee run -0 debugcallSimpleCommand --module testmodule
    DEBUG=debuggee run -0 debugcallSimpleCommand --module anotherModule

    assert_file_exists "${PWD}/debuggee.log"
    assert_sink_contains 'echo just a\\ test'
    assert_sink_not_contains 'echo just a\\ test' testmodule
    assert_sink_not_contains 'echo just a\\ test' anotherModule
}

@test "with DEBUGGEE:MODULE targeting, the invocation of only that module is recorded" {
    DEBUG=debuggee:testmodule run -0 debugcallSimpleCommand
    DEBUG=debuggee:testmodule run -0 debugcallSimpleCommand --module testmodule
    DEBUG=debuggee:testmodule run -0 debugcallSimpleCommand --module anotherModule

    assert_file_exists "${PWD}/debuggee.log"
    assert_sink_not_contains 'echo just a\\ test'
    assert_sink_contains 'echo just a\\ test' testmodule
    assert_sink_not_contains 'echo just a\\ test' anotherModule
}
