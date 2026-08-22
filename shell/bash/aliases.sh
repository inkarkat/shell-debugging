#!/bin/bash source-this-script

# dm			Open the last debug log used by withDebug in the pager.
dm()
{
    local -r DATA_DIRSPEC="${XDG_DATA_HOME:-${HOME}/.local/share}"
    local -r WITHDEBUG_LASTLOG_FILESPEC="${DATA_DIRSPEC}/withDebug-last-log"
    local lastDebugLogFilespec=; [ -r "$WITHDEBUG_LASTLOG_FILESPEC" ] \
	&& <"$WITHDEBUG_LASTLOG_FILESPEC" IFS=$'\n' read -r lastDebugLogFilespec \
	&& [ -r "$lastDebugLogFilespec" ] \
	|| return 1

    typeset -a pager=("${PAGER:-less}" --RAW-CONTROL-CHARS); [ -t 1 ] || pager=(cat)
    "${pager[@]}" "$lastDebugLogFilespec"
}
