#!/bin/bash

set -e

source "$HOME/perl5/perlbrew/etc/bashrc"
perlbrew use 5.16.3
perlbrew install-cpanm
cpanm Dist::Zilla
dzil authordeps --missing | cpanm -v
dzil listdeps --missing | cpanm -v
dzil install --install-command='cpanm -v .'
