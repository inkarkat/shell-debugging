#!/bin/bash

case ",${TRACE:-}," in *,subordinate,*) [ -z "$BATS_TEST_NAME" ] || BASH_XTRACEFD=3; set -x;; esac
hostname
