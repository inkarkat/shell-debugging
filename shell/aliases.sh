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

alias dl='withDebug --list-targets'
optionmunge -s : HISTIGNORE 'dl:dl *'
alias dla='withDebuga --list-targets'
optionmunge -s : HISTIGNORE 'dla:dla *'

alias dt='withDebug --extension \&'
optionmunge -s : HISTIGNORE 'dt:dt *'
alias dta='withDebuga --extension \&'
optionmunge -s : HISTIGNORE 'dta:dta *'

alias ds='withDebug --same'
optionmunge -s : HISTIGNORE 'ds:ds *'
alias dsa='withDebuga --same'
optionmunge -s : HISTIGNORE 'dsa:dsa *'

alias dr='withDebug --recall'
optionmunge -s : HISTIGNORE 'dr:dr *'
