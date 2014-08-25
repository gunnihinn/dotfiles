dotfiles
========

This repo lets me keep my dotfiles up to date and makes it easy to
install them on different machines.

Installation and configuration
------------------------------

The install script is ``install``. Run it, it'll figure out the rest.

In detail, the install script will look at the variable ``to_install`` and
try to install every script listed in it.  If ``filename`` appears in
``to_install``, the script will install that dotfile as ``.filename``. Thus
``bashrc`` should contain the options that are normally found in
``.bashrc``, for example.

The install script will do one of these things for each ``filename`` it finds:

(1) If ``$HOME/.filename`` doesn't exist, it will create a symlink from it
to ``filename``.

(2) Else, if ``$HOME/.filename`` is a symlink to ``filename``, ``install``
does nothing.

(3) Else, ``install`` appends the line

    source /path/to/filename

to ``$HOME/.filename``.

 
todo
----

* Think about how to handle vim packages.
* Add more dotfiles.
* Extend install script. Add options and tests.
* What will the install script try to do if we add a file with a dot in
front of it to ``to_install``?
