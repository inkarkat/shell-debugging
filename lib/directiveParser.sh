#!/bin/bash source-this-script

unset remainingDebug
debugConsumeDirectiveInto()
{
    local -n directiveRef="${1:?}"; shift
    local sigil="${1:?}"; shift
    [ -n "${remainingDebug+t}" ] || remainingDebug=",${DEBUG},"

    case "$remainingDebug" in
	*,"${debuggee}${sigil}"*([^:,])"${module:+:}${module}",*)
	    directiveRef=",${remainingDebug},"; directiveRef="${directiveRef#*,${debuggee}${sigil}}"; directiveRef="${directiveRef%%${module:+:}${module},*}"
	    remainingDebug="${remainingDebug/",${debuggee}${sigil}${directiveRef}${module:+:}${module},"/,}"
	    return 0
	    ;;

	*)
	    unset remainingDebug
	    return 1
	    ;;
    esac
}
