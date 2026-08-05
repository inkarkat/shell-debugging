#!/bin/sh source-this-script

addAliasSupport withDebug \
    '12IPTailstv' \
    'list-targets|same|stdout|stderr|append|no-pager|inbox|to-separate-files|to-stderr|to-tty|no-timestamps|interactive|verbose' \
    'Mmx' \
    'extension|for|module|only-for|only-module'

alias d='withDebug'
IFS=: optionmunge HISTIGNORE 'd:d *'
alias dt='withDebug --extension \&'
IFS=: optionmunge HISTIGNORE 'dt:dt *'
alias ds='withDebug --same'
IFS=: optionmunge HISTIGNORE 'ds:ds *'
alias dr='withDebug --recall'
IFS=: optionmunge HISTIGNORE 'dr:dr *'
