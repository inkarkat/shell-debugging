#!/bin/sh source-this-script

addAliasSupport withDebug \
    '12IPTailstv' \
    'list-targets|same|stdout|stderr|append|no-pager|inbox|to-separate-files|to-stderr|to-tty|no-timestamps|interactive|verbose' \
    'Mmx' \
    'extension|for|module|only-for|only-module'

alias d='withDebug'
optionmunge -s : HISTIGNORE 'd:d *'
alias da='withDebuga'
optionmunge -s : HISTIGNORE 'da:da *'
completeAsCommand d da

# d?			Execute COMMAND while showing the COMMAND(s), MODULE(s),
#			and EXTENSION(s) that could be enabled; i.e. which debug
#			statements are actually hit and what they react on.
if [ ! "${KSH_VERSION:-}" ]; then
    # Korn shell doesn't support ? in alias names.
    alias 'd?'='withDebug --list-targets'
    optionmunge -s : HISTIGNORE 'd?:d? *'
    alias 'd?a'='withDebuga --list-targets'
    optionmunge -s : HISTIGNORE 'd?a:d?a *'
    completeAsCommand 'd?' 'd?a'
fi

# dt			Execute COMMAND while enabling tracing (set -x) for it.
alias dt='withDebug --extension \&'
optionmunge -s : HISTIGNORE 'dt:dt *'
alias dta='withDebuga --extension \&'
optionmunge -s : HISTIGNORE 'dta:dta *'
completeAsCommand dt dta

# ds			Execute COMMAND with the same debugging options as the
#			previous invocation of withDebug, optionally dropping
#			matching arguments or adding those not given to the
#			original command.
alias ds='withDebug --same'
optionmunge -s : HISTIGNORE 'ds:ds *'
alias dsa='withDebuga --same'
optionmunge -s : HISTIGNORE 'dsa:dsa *'
completeAsCommand ds dsa

# dr			Rerun the previous debugging COMMAND(s), optionally
#			dropping matching arguments or adding those not given to
#			the original command.
alias dr='withDebug --recall'
optionmunge -s : HISTIGNORE 'dr:dr *'

# dm			Open the last debug log used by withDebug in the pager.
alias dm='debug-recall'
optionmunge -s : HISTIGNORE 'dm:dm *'

# dc			Remove all debug log files created by withDebug in the
#			debug log directory.
alias dc='debug-clear'
optionmunge -s : HISTIGNORE 'dc:dc *'
