#!/bin/bash

set -e

source "$HOME/perl5/perlbrew/etc/bashrc"
perlbrew use 5.16.3
perlbrew install-cpanm
export PERL_CPANM_OPT="--mirror http://cpan.celogeek.com -v"
cpanm Dist::Zilla
dzil authordeps --missing | cpanm
dzil listdeps --missing | cpanm
dzil cover
dzil clean
git checkout master
git reset --hard origin/master
git checkout devel
git reset --hard origin/devel
git push --mirror git@github.com:celogeek/App-KeePass2.git
