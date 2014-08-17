#!/bin/sh

find . -name '*.dSYM' | xargs rm -r
rm -f src/stamp-h1
