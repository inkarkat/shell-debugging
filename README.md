# Shell Debugging

_Debugging aids for shell scripts._

### Dependencies

* Bash, GNU `sed`
* [inkarkat/shell-basics](https://github.com/inkarkat/shell-basics)
* [inkarkat/headers](https://github.com/inkarkat/headers) for the `debugtee` command

### Installation

* The `./bin` subdirectory is supposed to be added to `PATH`.
* The [shell/aliases.sh](shell/aliases.sh) script (meant to be sourced in `.bashrc`) defines Bash aliases around the provided commands.
* The [shell/completions.sh](shell/completions.sh) script (meant to be sourced in `.bashrc`) defines Bash completions for the provided commands.

### See Also

* [inkarkat/shell-testing](https://github.com/inkarkat/shell-testing) has test hooks and utilities for shell scripts. Many of those commands (among them a `testeval` variant closely related to `debugeval`) are also embedded in shell scripts, but activated by automated tests, not by the developer during debugging.
