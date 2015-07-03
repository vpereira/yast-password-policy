
YaST Password Policy Module
=======================

<!-- Adapt the used badges, keep the order unchanged so it is unified for all repositories.
  To use the badges replace "foo" by the real repository name.  -->
[![Travis Build](https://travis-ci.org/yast/yast-foo.svg?branch=master)](https://travis-ci.org/yast/yast-foobar)
[![Jenkins Build](http://img.shields.io/jenkins/s/https/ci.opensuse.org/yast-foo-master.svg)](https://ci.opensuse.org/view/Yast/job/yast-foo-master/)
[![Coverage Status](https://img.shields.io/coveralls/yast/yast-foobar.svg)](https://coveralls.io/r/yast/yast-foobar?branch=master)
[![Code Climate](https://codeclimate.com/github/yast/yast-foobar/badges/gpa.svg)](https://codeclimate.com/github/yast/yast-foobar)
[![Inline docs](http://inch-ci.org/github/yast/yast-foobar.svg?branch=master)](http://inch-ci.org/github/yast/yast-foobar)



Description
============

This module should be used as a single point for password policy definition.
Normally in Linux environments we have different password policies being applied
to different components: pam.d, libpwquality, etc

In this first release, this module has to endpoints configured:

1. pam.d
2. libpwquality

### Features ###

In a central place, configure multiple endpoints with a single password policy



Development
===========

This module is developed as part of YaST. See the
[development documentation](http://yastgithubio.readthedocs.org/en/latest/development/).


Getting the Sources
===================

To get the source code, clone the GitHub repository:

    $ git clone https://github.com/yast/<repository>.git

If you want to contribute into the project you can
[fork](https://help.github.com/articles/fork-a-repo/) the repository and clone your fork.


Development Environment
=======================

The module has no external dependencies. It uses ERB and minitests which are part of ruby

Testing Environment
===================

````rake test````

It can run in a docker container. To run it, you must build the image:

````docker build -t your-user/opensuse:13.2_with_ruby .````

and run it:

````docker run -t -i vpereira/opensuse:13.2_with_ruby````

it will run your container starting yast in the ncurses mode

Troubleshooting
===============


Contact
=======

If you have any question, feel free to ask at the [development mailing
list](http://lists.opensuse.org/yast-devel/) or at the
[#yast](https://webchat.freenode.net/?channels=%23yast) IRC channel on freenode.
