#!/bin/bash source-this-script

eval "foo() { echo ${1:-foo}; }"
sleep 0.1
hostname
