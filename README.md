work-on
=======

A utility to manage your projects and make working on them as seemless as possible.
Basically you edit a small yaml file where you specify your project directory and the terminal windows and tabs
you want to open.

Example
-------

Config files should be placed inside ~/.config/work-on/.
Yaml files should end in .yaml or .yml

this is the actual config file i use for work-on:

    project-dir: ~/Projects/work-on
    tab1:
      - git status
    tab2:
      - mvim

this opens 2 new tabs and executes above commands
you can also open new windows

    project-dir: ~/Projects/work-on
    window1:
      tab1:
        - ls
      tab2:
        - git status
    window2:
      tab1:
        - mvim

You can guess what the above would do.

NOTE: At the moment only Mac OS X is supported, but support for linux is coming real soon.

Copyright
=========


Copyright (c) 2011 Toon Willems. See LICENSE.txt for
further details.

