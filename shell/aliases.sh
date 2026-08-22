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

if [ ! "${KSH_VERSION:-}" ]; then
    # Korn shell doesn't support ? in alias names.
    alias 'd?'='withDebug --list-targets'
    optionmunge -s : HISTIGNORE 'd?:d? *'
    alias 'd?a'='withDebuga --list-targets'
    optionmunge -s : HISTIGNORE 'd?a:d?a *'
    completeAsCommand 'd?' 'd?a'
fi

alias dt='withDebug --extension \&'
optionmunge -s : HISTIGNORE 'dt:dt *'
alias dta='withDebuga --extension \&'
optionmunge -s : HISTIGNORE 'dta:dta *'
completeAsCommand dt dta

alias ds='withDebug --same'
optionmunge -s : HISTIGNORE 'ds:ds *'
alias dsa='withDebuga --same'
optionmunge -s : HISTIGNORE 'dsa:dsa *'
completeAsCommand ds dsa

alias dr='withDebug --recall'
optionmunge -s : HISTIGNORE 'dr:dr *'
