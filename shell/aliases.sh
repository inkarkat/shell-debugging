#!/bin/sh source-this-script

addAliasSupport withDebug \
    '12IPTailstv' \
    'list-targets|same|stdout|stderr|append|no-pager|inbox|to-separate-files|to-stderr|to-tty|no-timestamps|interactive|verbose' \
    'Mmx' \
    'extension|for|module|only-for|only-module'

alias d='withDebug'
IFS=: optionmunge HISTIGNORE 'd:d *'
alias da='withDebuga'
IFS=: optionmunge HISTIGNORE 'da:da *'

alias dl='withDebug --list-targets'
IFS=: optionmunge HISTIGNORE 'dl:dl *'
alias dla='withDebuga --list-targets'
IFS=: optionmunge HISTIGNORE 'dla:dla *'

alias dt='withDebug --extension \&'
IFS=: optionmunge HISTIGNORE 'dt:dt *'
alias dta='withDebuga --extension \&'
IFS=: optionmunge HISTIGNORE 'dta:dta *'

alias ds='withDebug --same'
IFS=: optionmunge HISTIGNORE 'ds:ds *'
alias dsa='withDebuga --same'
IFS=: optionmunge HISTIGNORE 'dsa:dsa *'

alias dr='withDebug --recall'
IFS=: optionmunge HISTIGNORE 'dr:dr *'
