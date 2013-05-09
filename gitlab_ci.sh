#!/bin/bash

set -x -e

perlbrew use 5.16.3
cpanm Dist::Zilla
dzil authordeps --missing | cpanm -v
dzil listdeps --missing | cpanm -v
dzil install --install-command='cpanm -v .'
