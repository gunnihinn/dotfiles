dotfiles
========

This repo lets me keep my dotfiles up to date and makes it easy to
install them on different machines.

Installation and configuration
------------------------------

The install script is `install`. Run it, it'll figure out the rest.

In detail, the install script will look at the variable `to_install` and
try to install every dotfile listed in it.  If `dotfile` appears in
`to_install`, the script will install that dotfile as `.dotfile`. Thus
`bashrc` should contain the options that are normally found in
`.bashrc`, for example.

The install script will do one of these things for each `dotfile` it finds:

1. If `$HOME/.dotfile` doesn't exist, it will create a symlink from it
to `dotfile`.

2. Else, if `$HOME/.dotfile` is a symlink to `dotfile`, it does
nothing.

3. Else, `install` appends the line

    source /path/to/dotfile

to `$HOME/.dotfile`.

 
TODO
----

* Think about how to handle vim packages; pull vim-latex and such if needed.
* Add more dotfiles.
* Extend install script. Add options and tests.
* What will the install script try to do if we add a file with a dot in
front of it to `to_install`?
* Stop `install` from appending the same source line many times.
* Some of the dotfiles are shell scripts. Isn't it a problem if those get
appended to other shell scripts?
