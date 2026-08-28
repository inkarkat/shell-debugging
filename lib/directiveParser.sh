#!/bin/bash source-this-script

unset remainingDebug
debugConsumeDirectiveInto()
{
    local -n directiveRef="${1:?}"; shift
    local sigil="${1:?}"; shift
    [ -n "${remainingDebug+t}" ] || remainingDebug=",${DEBUG},"

    case "$remainingDebug" in
	*,"${debuggee}${module:+:}${module}${sigil}"*([^,]),*)
	    directiveRef=",${remainingDebug},"; directiveRef="${directiveRef#*,${debuggee}${module:+:}${module}${sigil}}"; directiveRef="${directiveRef%%,*}"
	    remainingDebug="${remainingDebug/",${debuggee}${module:+:}${module}${sigil}${directiveRef},"/,}"
	    return 0
	    ;;

	*)
	    unset remainingDebug
	    return 1
	    ;;
    esac
}
