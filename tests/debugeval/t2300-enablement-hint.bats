#!/usr/bin/env bats

load sink

@test "with debug[eval] targeting, the activation information is logged in the sink" {
    for value in debug{,eval}
    do
	setup
	DEBUG="$value" run -0 debugcallSimpleCommand \
	    && assert_output 'echo just a\ test' \
	    && assert_sink_equals 'debugeval: Will activate with DEBUG=debuggee[!|&|~|=OTHER-COMMAND|@[N-]FILE|^=PREFIX|+=SUFFIX|?PREDICATE]' \
	    || fail "$value"
    done
}

@test "with debug targeting, the activation information for used modules is logged" {
    DEBUG=debug run -0 debugcallSimpleCommand --module testmodule
    assert_sink_equals 'debugeval: Will activate with DEBUG=debuggee:testmodule[!|&|~|=OTHER-COMMAND|@[N-]FILE|^=PREFIX|+=SUFFIX|?PREDICATE]'
}
