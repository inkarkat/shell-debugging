#!/bin/sh source-this-script

addAliasSupport withDebug \
    '12IPTaistv' \
    'stdout|stderr|append|no-pager|inbox|to-separate-files|to-tty|no-timestamps|interactive|verbose' \
    'Mmx' \
    'extension|for|module|only-module'

alias d='withDebug'
IFS=: optionmunge HISTIGNORE 'd:d *'
alias ds='withDebug --same'
IFS=: optionmunge HISTIGNORE 'ds:ds *'
alias dr='withDebug --recall'
IFS=: optionmunge HISTIGNORE 'dr:dr *'
