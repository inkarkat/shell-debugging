#!/usr/bin/env bats

load fixture

@test "without DEBUG, the scriptlet sourcing is executed" {
    run -0 "${BATS_TEST_DIRNAME}/bin/evaled"
    assert_output - <<EOF
scriptlet done
lulli
EOF
}

@test "with different DEBUG target, the scriptlet sourcing is executed" {
    DEBUG=aDifferentDebuggee run -0 "${BATS_TEST_DIRNAME}/bin/evaled"
    assert_output - <<EOF
scriptlet done
lulli
EOF
}

@test "with DEBUG targeting of the script, the scriptlet sourcing is executed" {
    DEBUG=evaled run -0 "${BATS_TEST_DIRNAME}/bin/evaled"
    assert_output - <<EOF
scriptlet done
lulli
EOF
}

@test "with DEBUG targeting of the script and the ! extension, the scriptlet sourcing is not executed" {
    DEBUG=evaled\! run -127 "${BATS_TEST_DIRNAME}/bin/evaled"
    assert_output -e 'foo: command not found'
}

@test "with DEBUG targeting of the script and =OTHER-COMMAND, the scriptlet sourcing is replaced" {
    DEBUG=evaled='foo() { echo overridden; }' run -0 "${BATS_TEST_DIRNAME}/bin/evaled"
    assert_output - <<EOF
overridden
EOF
}

@test "with DEBUG targeting of the script and +=SUFFIX, the scriptlet sourcing is amended" {
    DEBUG=evaled+=-lala run -0 "${BATS_TEST_DIRNAME}/bin/evaled"
    assert_output - <<EOF
scriptlet done
lulli-lala
EOF
}

@test "with DEBUG targeting of the scriptlet and +=SUFFIX, the scriptlet execution is amended" {
    DEBUG=scriptlet+=' NOW' run -0 "${BATS_TEST_DIRNAME}/bin/evaled"
    assert_output - <<EOF
scriptlet done NOW
lulli
EOF
}

@test "with DEBUG targeting of both script and scriptlet and +=SUFFIX, the executions are amended" {
    DEBUG=evaled+=-lala,scriptlet+=' NOW' run -0 "${BATS_TEST_DIRNAME}/bin/evaled"
    assert_output - <<EOF
scriptlet done NOW
lulli-lala
EOF
}
